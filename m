Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267134AbTAWXKf>; Thu, 23 Jan 2003 18:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbTAWXKf>; Thu, 23 Jan 2003 18:10:35 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:56741 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S267134AbTAWXKd>; Thu, 23 Jan 2003 18:10:33 -0500
Message-ID: <20030123231913.26663.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Lee Chin" <leechin@mail.com>
To: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Date: Thu, 23 Jan 2003 18:19:13 -0500
Subject: debate on 700 threads vs asynchronous code
X-Originating-Ip: 66.123.16.67
X-Originating-Server: ws1-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I am discussing with a few people on different approaches to solving a scale problem I am having, and have gotten vastly different views

In a nutshell, as far as this debate is concerned, I can say I am writing a web server.

Now, to cater to 700 clients, I can
a) launch 700 threads that each block on I/O to disk and to the client (in reading and writing on the socket)

OR

b) Write an asycnhrounous system with only 2 or three threads where I manage the connections and stack (via setcontext swapcontext etc), which is progromatically a little harder

Which way will yeild me better performance, considerng both approaches are implemented optimally?

Thanks
Lee
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Meet Singles
http://corp.mail.com/lavalife

