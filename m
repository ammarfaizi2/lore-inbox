Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130053AbRBQTrk>; Sat, 17 Feb 2001 14:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRBQTrU>; Sat, 17 Feb 2001 14:47:20 -0500
Received: from web1304.mail.yahoo.com ([128.11.23.154]:55306 "HELO
	web1304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130053AbRBQTrP>; Sat, 17 Feb 2001 14:47:15 -0500
Message-ID: <20010217194709.283.qmail@web1304.mail.yahoo.com>
Date: Sat, 17 Feb 2001 11:47:09 -0800 (PST)
From: Mark Swanson <swansma@yahoo.com>
Subject: [help] _syscall2 fails with -fPIC
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am building a -fPIC shared object that will define and access a Linux
kernel system call, but _syscall2 fails with -fPIC .so compilation.
What can I do?
 
        F.E. the statement:
 
_syscall2 (int, tux, unsigned int, action, user_req_t *, req)
 
Gives the following gcc error when compiled with -fPIC:
 
tst.c: In function `tux':
tst.c:62: Invalid `asm' statement:
tst.c:62: fixed or forbidden register 3 (bx) was spilled for class
BREG.

If the -fPIC isn't there it compiles fine. Unfortunately I need to find
another way as I have to use -fPIC.

Thanks in advance for any suggestions.


=====
A camel is ugly but useful; it may stink, and it may spit, but it'll get you where you're going. - Larry Wall -

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
