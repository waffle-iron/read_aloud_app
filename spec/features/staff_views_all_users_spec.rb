require 'rails_helper'

RSpec.describe "Staff views all users" do
  it "they see a list of all volunteers" do
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      active: true,
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    volunteer = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      active: true,
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)

    visit root
    fill_in "username", with: staff.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Manage"
    click_on "View All Volunteers"

    expect(current_path).to eq(staff_users_path(staff))
    expect(page).to have_content("Hermione")
    expect(page).to have_content("Granger")
    expect(page).to have_content("hgranger")
    expect(page).to have_content("Volunteer")

    expect(page).to have_content("Minerva")
    expect(page).to have_content("McGonagall")
    expect(page).to have_content("mmcgonagall")
    expect(page).to have_content("Staff")
  end
end
