Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135915AbREBFE5>; Wed, 2 May 2001 01:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135921AbREBFEr>; Wed, 2 May 2001 01:04:47 -0400
Received: from [202.161.131.226] ([202.161.131.226]:48132 "EHLO
	parijat.info.com.np") by vger.kernel.org with ESMTP
	id <S135896AbREBFEa>; Wed, 2 May 2001 01:04:30 -0400
Date: Wed, 2 May 2001 10:56:34 +0545 (NPT)
From: Ajay Dangol <ajay.dangol@parijat.info.com.np>
To: linux-kernel@vger.kernel.org
cc: linux-admin@vger.kernel.org
Subject: someody help me out
Message-ID: <Pine.LNX.4.10.10105021055120.5093-100000@parijat.info.com.np>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello all,
           I am just a beginner in linux programming and I want to write a
script for disconnecting users in cisco router.Could anybody help me out.
           The scenario is like this. I have been using Cisco router2500
and in that we have users connected to it in async port.

when I execute the command.

Router#sh users

I will get something like this

Line          User             Host(s)            Idle location

1 tty 1        user             async interface    dial-up for ISP

now if i execute the command

Router#clear line 1
 
the "user" will be disconnected from the router.

           Now what I want is to write a script that will disconnect the
user from the router.

           When you telnet to the router the process goes like this

telnet ip address

then it will ask for 
password:

then you get something like this

router>en         (you have to type en to enable it)

then again it asks for password

password:  

once you give the password

Router#show users         (you have to execute the following command)


then if you want to disconnect particular user then you give command

Router#clear line 1 

how do i put the whole thing in a script and achieve the above .Could anybody 
help me out.

Thanking you,
Ajay Dangol.


