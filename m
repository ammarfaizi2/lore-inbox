Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132826AbRDPB6p>; Sun, 15 Apr 2001 21:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132830AbRDPB6f>; Sun, 15 Apr 2001 21:58:35 -0400
Received: from www7.networkshosting.com ([209.12.212.210]:17547 "HELO
	www7.networkshosting.com") by vger.kernel.org with SMTP
	id <S132826AbRDPB6P>; Sun, 15 Apr 2001 21:58:15 -0400
Message-ID: <3ADA524A.7038A81C@boosthardware.com>
Date: Mon, 16 Apr 2001 11:00:42 +0900
From: Patrick Shirkey <pshirkey@boosthardware.com>
Organization: Boost Hardware
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: ko, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Files not linking/replacing.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I hope this is the correct place to report to.

I have installed kernel 2.4.3 but my system is having a few problems
compiling things. Not all software is having problems it just seems to
be the most important ones. like mozilla or alsa-driver, I would like to
try others to test this but it's kind of frustrating and time consuming.

I installed the kernel in /usr/local/src because the install file says
not to do it in /usr/src anymore because of kernel header dependencies.

The system is booting and obviously I can use the net but the main
problem seems toi be that a lot of important files have not benn updated
or relinked to the right dir.

I installed the new kernel onto Mandrake 7.0 which ships with 2.2.14.

I'm using a PIII
and have verified that my software is upto the minimal requirements
according to the /documentation/changes file. All except mkinitrd which
I can't install becuse I have an old version of rpm and cannot find the
tar.gz file on the net.

An example of what my system is doing:

I compile the latest stable mozilla.
First off it complains that /usr/include/bits/errno.h doesn't point to
the right place.
So I remove it and link /usr/local/src/linux/include/asm/errno.h to
/usr/include/bits/errno.h and recompile.
It gets past that point then complains about /usr/include/bits/socket.h
so I repeat the process.

The futility of doing this occurs to me. So I write in to this list in
the hope that someone may know what I have done wrong or can offer me
some help to debug.

Any ideas?

Patrick Shirkey.

-- 
Boost Hardware.
Importing Korean Computer Hardware to New Zealand.

Http://www.boosthardware.com for latest stock and prices.
