Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262025AbRETPKB>; Sun, 20 May 2001 11:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262026AbRETPJv>; Sun, 20 May 2001 11:09:51 -0400
Received: from web13907.mail.yahoo.com ([216.136.175.70]:28939 "HELO
	web13907.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262025AbRETPJq>; Sun, 20 May 2001 11:09:46 -0400
Message-ID: <20010520150945.66552.qmail@web13907.mail.yahoo.com>
Date: Sun, 20 May 2001 08:09:45 -0700 (PDT)
From: szonyi calin <caszonyi@yahoo.com>
Subject: BUG ? and questions
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
My name is Calin
I have a Cx 486/66 with 12 Megs of ram AST computer
gcc 2.95.3, glibc 2.1.3, make 3.79.1 binutils 2.11 ??
Problems:
1. When I try to run multiple (2) compilations on a
2.4.4 kernel usually one
of them dies -- if it's gcc - signal 11 ,  if it's sh
or rarely  make -
segmentation fault.

It is not a hardware problem (with kernel 2.2.x it
does not do this
and I have a cooler on my cpu)

2. I compiled a kernel 2.4.3 with XFS and sound as a
module (I use alsa
sound driver), and when I try to insmod soundcore.o it
says about some
unresolved symbols (one of them is printk )
I don't have this problem with any of the originals
2.4.x kernels
(downloaded from kernel.org)

Questions:
1. I  have a vlb system and the kernel does not report
an IDE controler
I presume there is one. Is there a way to find out
what type it is
because a read about buggy 486 motherboards and I want
to be sure
that mine is not (It does not seems to be -- I have my
system
from about a year and a half and I have no problems )

2. I saw in .config in the root of kernel tree
"#CONFIG_BLK_DEV_IDEDISK_SEAGATE
is not set ";
the same for IBM, Maxtor etc. If I set this will be
any performance inprovements ?

3. I noticed that if I compile RTC  in the kernel my
system runs smootly ?
Is this just an illusion ?

Sorry for bothering you
Sorry if the questions are silly

Bye

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
