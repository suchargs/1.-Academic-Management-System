-- Create StudentInfo Table
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(100),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS VARCHAR(200)
);
select * from StudentInfo;

-- Create CoursesInfo Table
CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(100),
    COURSE_INSTRUCTOR_NAME VARCHAR(100)
);
select * from CoursesInfo;

-- Create EnrollmentInfo Table
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20) CHECK (ENROLL_STATUS IN ('Enrolled', 'Not Enrolled')),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);
select * from EnrollmentInfo;

INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS) VALUES 
(1, 'Sucharita', '2000-04-15', '9876543210', 'suchargs@gmail.com', '123 Maple Street'),
(2, 'Madhuri', '1999-07-22', '9123456780', 'madhuri@gmail.com', '456 Elm Street'),
(3, 'Rama', '2001-01-10', '9987654321', 'rama@gmail.com', '789 Oak Street');

INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME) VALUES 
(101, 'Mathematics', 'Dr. Newton'),
(102, 'Physics', 'Dr. Tesla'),
(103, 'Chemistry', 'Dr. Curie');

INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS) VALUES
(1, 1, 101, 'Enrolled'),
(2, 2, 102, 'Enrolled'),
(3, 3, 103, 'Not Enrolled'),
(4, 1, 102, 'Enrolled'),
(5, 2, 103, 'Enrolled');

SELECT STU_NAME, PHONE_NO, EMAIL_ID, ENROLL_STATUS
FROM StudentInfo
JOIN EnrollmentInfo ON StudentInfo.STU_ID = EnrollmentInfo.STU_ID;

SELECT COURSE_NAME
FROM CoursesInfo
JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
WHERE EnrollmentInfo.STU_ID = 1 AND ENROLL_STATUS = 'Enrolled';

SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo;

SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_ID = 101;

SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_ID IN (101, 102);

SELECT COURSE_NAME, COUNT(EnrollmentInfo.STU_ID) AS Enrolled_Students
FROM CoursesInfo
JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
WHERE ENROLL_STATUS = 'Enrolled'
GROUP BY COURSE_NAME;

SELECT STU_NAME
FROM StudentInfo
JOIN EnrollmentInfo ON StudentInfo.STU_ID = EnrollmentInfo.STU_ID
WHERE EnrollmentInfo.COURSE_ID = 102 AND ENROLL_STATUS = 'Enrolled';

SELECT COURSE_INSTRUCTOR_NAME, COUNT(EnrollmentInfo.STU_ID) AS Enrolled_Students
FROM CoursesInfo
JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
WHERE ENROLL_STATUS = 'Enrolled'
GROUP BY COURSE_INSTRUCTOR_NAME;

SELECT STU_NAME, COUNT(DISTINCT COURSE_ID) AS Courses_Enrolled
FROM StudentInfo
JOIN EnrollmentInfo ON StudentInfo.STU_ID = EnrollmentInfo.STU_ID
WHERE ENROLL_STATUS = 'Enrolled'
GROUP BY STU_NAME
HAVING COUNT(DISTINCT COURSE_ID) > 1;

SELECT COURSE_NAME, COUNT(EnrollmentInfo.STU_ID) AS Enrolled_Students
FROM CoursesInfo
JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
WHERE ENROLL_STATUS = 'Enrolled'
GROUP BY COURSE_NAME
ORDER BY Enrolled_Students DESC;