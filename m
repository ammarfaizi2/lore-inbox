Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262458AbSJKOFK>; Fri, 11 Oct 2002 10:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262461AbSJKOFK>; Fri, 11 Oct 2002 10:05:10 -0400
Received: from barkley.vpha.health.ufl.edu ([159.178.78.160]:34500 "EHLO
	barkley.vpha.health.ufl.edu") by vger.kernel.org with ESMTP
	id <S262458AbSJKOFK>; Fri, 11 Oct 2002 10:05:10 -0400
Message-ID: <1034345470.3da6dbfe5451d@webmail.health.ufl.edu>
Date: Fri, 11 Oct 2002 10:11:10 -0400
From: sridhar vaidyanathan <sridharv@ufl.edu>
To: linux-kernel@vger.kernel.org
Subject: kgdb stty problem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 163.181.250.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for the posting it the second time. i had missed the subject the first 
time.

I am trying to debug a kernel over a remote serial console. I get 
Ignoring packet error .. 
kgdb page suggests that it might be due to the speed mismatch. i tried 
stty ispeed 9600 ospeed 9600 < /dev/ttyS0 
on the development machine and have passed serial=0,9600n8 option and 
gdbbaud=9600 via lilo to the debug kernel. 
 
when i run 
%stty speed 
on the development machine it still reports 38400. 
so i changed the gdbbaud and serial= values to 38400 on the test machine. even 
this doesn't work. 
any ideas
--sridhar
ps: i have tried redirecting the kernel messages( without patching it with 
kgdb) over the serial line and read it with minicom . that works fine. 
please email as i am not subscribed. 
