<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>掌上青协</title>
    <script src="https://cdn.bootcss.com/jquery/2.1.4/jquery.js"></script>
    <script type="text/javascript">
        /* const serverPath = 'http://localhost:8787/';
         const access_token = '';
         */
        var user = {
            userId: null,
            studentId: null,
            name: null
        };

        //模拟Get请求
        function ajaxRequestGet(uri) {
            /* var server = serverPath;
            var url = server + uri; */
            var url = uri;
            $.ajax({
                type: 'GET',
                contentType: 'application/json',
                dataType: 'json',
                url: url,
                success: function (response) {
                    console.log(response);
                },
                error: function () {
                    console.log('Ajax请求失败！');
                }
            });
        }

        //模拟Post请求
        function ajaxRequestPost(uri, method, data) {
            /* 	var server = serverPath;
                var url = server + uri; */
            var url = uri;
            $.ajax({
                type: method,
                contentType: 'application/json;charset=UTF-8',//此句话需要配合 json序列化方法使用
                dataType: 'json',
                data: JSON.stringify(data),
                url: url,
                success: function (response) {
                    console.log(response);
                },
                error: function (response) {
                    console.log('Ajax error');
                    console.log(response);
                }
            });
        }

        //非json格式的请求
        function ajaxWithoutJson(uri, method, header) {
            $.ajax({
                type: method,
                contentType: 'application/json;charset=UTF-8',//此句话需要配合 json序列化方法使用
                dataType: 'json',
                data: JSON.stringify(header),
                url: uri,
                beforeSend: function (request) {
                    request.setRequestHeader("studentId", header.studentId);
                    request.setRequestHeader("password", header.password)
                },
                success: function (response) {
                    var result = response['data'];
                    if (result && result['user']) {
                        var obj = result['user'];
                        user.name = obj['name'];
                        user.userId = obj['id'];
                        user.studentId = obj['studentId'];
                        console.log(user);
                    }
                    console.log(response);
                },
                error: function (response) {
                    console.log('Ajax error');
                    console.log(response);
                }
            });
        }


        $(function () {
            $("#getMyVolunteerService").click(function () {
                ajaxRequestGet("activity/"+ $("input[name='identification']").val()+"/activities");
            });

            $("#getAllActivities").click(function () {
                ajaxRequestGet("activity/home?page=1&size=2");
            });

            $("#releaseActivity").click(function () {
                var data = {
                    'name': '敬老院活动',
                    'managerId': 1,
                    'hourPerTime': 4,
                    'regTime': '2018-03-04 17:30:00',
                    /* 'regEndTime': new Date('2018-03-04 17:00:00'),
                    'interviewTime': new Date('2018-03-05 10:30:00'),
                    'startTime': new Date('2018-03-12 10:00:00'),
                    'endTime': new Date('2018-03-12 14:00:00'), */
                    'regEndTime':'2018-03-04 17:30:00',
                    'interviewTime':'2018-03-05 10:30:00',
                    'startTime': '2018-03-12 10:00:00',
                    'endTime': '2018-03-12 14:00:00',
                    //'createTime': new Date(),
                    'general': '东院敬老院活动，打扫卫生',
                    'needVolunteers': 10,
                    'place': '东院敬老院',
                    'type': 2,
                    'status': 1,
                    'sponsor':'管理学院',
                    'homepagePic':'/qingxie-img/pics/4373f88efa67250db592fe7679d46849.jpg'
                };
                ajaxRequestPost('activity/releaseActivity', 'PUT', data);
            });

            $("#getForks").click(function () {
                ajaxRequestGet("activity/"+ $("input[name='identification']").val()+"/forks");
            });

            $("#getWorks").click(function () {
                ajaxRequestGet("activity/"+ $("input[name='identification']").val()+"/works");
            });

            $("#getDetails").click(function () {
                ajaxRequestGet("activity/"+ $("input[name='identification']").val()+"/details");
            });

            $("#joinActivity").click(function () {
                ajaxRequestPost("activity/"+$("input[name='identification']").val()+"/"
                    +$("input[name='password']").val()+"/join","POST","");
            });

            $("#pushActivity").click(function () {
                alert("敬请期待~~");
                ///{activityId}/{userId}/join
            });

            $("#login").click(function () {
                var data = {
                    'studentId': $("input[name='identification']").val(),
                    'password': $("input[name='password']").val()
                };
                console.log(data.studentId);
                console.log(data.password);
                ajaxWithoutJson("/user/login", 'POST', data);
            });
            $("#getResume").click(function () {
                ajaxRequestGet("user/" + $("input[name='identification']").val() + "/resume");
            });

            $("#getIcon").click(function () {
                ajaxRequestGet("user/3/icon/get");
            });
            $("#updateUserInfo").click(function () {
                var data = {
                    'id': 3,
                    'telephone': '18988964207',
                    'email': 'evansqqlove@outlook.com',
                    'qq': '1036670250'
                };
                ajaxRequestPost("/user/3/info/update", 'PUT', data);
            });
            $("#updateExp").click(function () {
                var data = {
                    'id': 7,
                    'userId': 3,
                    'activityName': '微笑百事达',
                    'end': new Date()
                };
                ajaxRequestPost("/user/3/experience/update", 'PUT', data);
            });
            $("#addExp").click(function () {
                var data = {
                    'userId': 3,
                    'activityName': '早起打卡',
                    'end': new Date()
                };
                ajaxRequestPost("/user/3/experience/add", 'POST', data);
            });
            $("#deleteExp").click(function () {
                var data = {
                    'id': 8,
                    'userId': 3,
                    'activityName': '早起打卡',
                    'end': new Date()
                };
                ajaxRequestPost("/user/3/experience/delete", 'DELETE', data);
            });
            $("#addFork").click(function () {
                var data = {
                    'userId': 1,
                    'activityId': 2,
                };
                ajaxRequestPost("activity/addFork", 'POST', data);
            });
            $("#getHomePagePic").click(function () {
                ajaxRequestGet("activity/getHomePagePic");
            });
            $("#boostActivity").click(function () {
                ajaxRequestPost("activity/11/boostActivity", 'POST', null);
            });
            $("#getApplyNumber").click(function () {
                ajaxRequestGet("activity/11/getApplyNumber");
            });
            $("#getUserActivityHoursByUserId").click(function () {
                ajaxRequestGet("vhours/1/detailsByUserId");
            });
            $("#getUserActivityHoursByActivityId").click(function () {
                ajaxRequestGet("vhours/11/detailsByActivityId?page=2&size=2");
            });
            $("#getUserHoursByClassId").click(function () {
                ajaxRequestGet("vhours/44/general?page=1&size=3");
            });
            $("#getVolunteerNumber").click(function () {
                ajaxRequestGet("activity/8/volunteers");
            });
            $("#arriveConfirm").click(function () {
                var data = [{
                    'userId': 1,
                    'isArrived': true,
                },
                {
                    'userId': 3,
                    'isArrived': true,
                }]
                ajaxRequestPost("activity/2/arriveConfirm", 'POST', data);
            });
            $("#modifyConfirm").click(function () {
                var data = [{
                    'userId': 1,
                    'isArrived': false,
                },
                {
                    'userId': 3,
                    'isArrived': false,
                }]
                ajaxRequestPost("activity/2/modifyConfirm", 'POST', data);
            });
        })
    </script>
</head>
<body>
<h4>活动签到修改<input type="button" value="/{activityId}/modifyConfirm" id="modifyConfirm"/></h4>

<h4>活动签到确认<input type="button" value="/{activityId}/arriveConfirm" id="arriveConfirm"/></h4>

<h4>获取活动对应的所有志愿者<input type="button" value="/{activityId}/volunteers" id="getVolunteerNumber"/></h4>

<h4>获取班级所有学生总工时<input type="button" value="/vhours/{classId}/general" id="getUserHoursByClassId"/></h4>

<h4>获取某活动所有人工时详情<input type="button" value="/vhours/{activityId}/detailsByActivityId" id="getUserActivityHoursByActivityId"/></h4>

<h4>我的志愿工时查询<input type="button" value="/vhours/{userId}/detailsByUserId" id="getUserActivityHoursByUserId"/></h4>

<h4>获取某个活动报名人数<input type="button" value="/{activityId}/getApplyNumber" id="getApplyNumber"/></h4>

<h4>活动推进<input type="button" value="/{activityId}/boostActivity" id="boostActivity"/></h4>

<h4>获取首页轮播图<input type="button" value="/activity/getHomePagePic" id="getHomePagePic"/></h4>

<h4>添加至我的收藏<input type="button" value="/activity/addFork" id="addFork"/></h4>

<h4>我的志愿服务<input type="button" value="/{userId}/activities" id="getMyVolunteerService"/></h4>

<h4>首页<input type="button" value="/activity/home" id="getAllActivities"/></h4>

<h4>发布活动接口测试<input type="button" value="ReleaseActivity" id="releaseActivity"/></h4>

<h4>我的志愿工作<input type="button" value="/{userId}/works" id="getWorks"/></h4>

<h4>我的收藏<input type="button" value="/{userId}/forks" id="getForks"/></h4>

<h4>活动详情<input type="button" value="/{activityId}/details" id="getDetails"/></h4>

<h4>发布推文<input type="button" value="/{userId}/add" id="pushActivity"/></h4>

<h4>活动报名(在下面的登陆接口测试中，分别填入activityid和userid)<input type="button" value="/{activityId}/{userId}/join" id="joinActivity"/></h4>

<h4>活动照片上传
    <form action="/activity/3/pic/add" enctype="multipart/form-data" method="post">
        请选择图片:<input type="file" name="pic" id="pic" value="【图片】">
        <input type="submit" value="上传" id="uploadPic">
    </form>
</h4>

<h4>登陆接口测试</h4>
<form action="/user/login" method="post">
    <p>identification: <input type="text" name="identification" class="text-input"/><label>测试账号246666,密码4455</label></p>
    <p>password: <input type="text" name="password" class="text-input"/></p>
    <%--<input type="submit" value="submit">--%>
    <input type="button" value="login" id="login"> <input type="button" value="getResume" id="getResume">
</form>
<h4>测试头像上传
    <form action="/user/3/icon/update" enctype="multipart/form-data" method="post">
        请选择头像:<input type="file" name="icon" id="icon" value="【头像】">
        <input type="submit" value="上传" id="updateIcon">
    </form>
</h4>

<h4>获取头像地址<input type="button" value="/user/{userId}/icon/get" id="getIcon"></h4>

<h4>个人信息更新<input type="button" value="/user/{userId}/info/update" id="updateUserInfo"></h4>

<h4>活动经历更新操作</h4>
<input type="button" value="/user/{userId}/experience/add" id="addExp">
<input type="button" value="/user/{userId}/experience/delete" id="deleteExp">
<input type="button" value="/user/{userId}/experience/update" id="updateExp">

<h4>数据导入接口</h4>
<form action="/system//users/import" enctype="multipart/form-data" method="post">
    请选择文件:<input type="file" name="studentData" id="studentData" value="【学生信息文件】">
    <input type="submit" value="上传" id="updatedata">
</form>

</body>
<script src="http://cdn.bootcss.com/blueimp-md5/1.1.0/js/md5.js"></script>
</html>