Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314582AbSDTIXP>; Sat, 20 Apr 2002 04:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSDTIXO>; Sat, 20 Apr 2002 04:23:14 -0400
Received: from web13307.mail.yahoo.com ([216.136.175.43]:54544 "HELO
	web13307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314582AbSDTIXO>; Sat, 20 Apr 2002 04:23:14 -0400
Message-ID: <20020420082314.34809.qmail@web13307.mail.yahoo.com>
Date: Sat, 20 Apr 2002 01:23:14 -0700 (PDT)
From: Shobana Valli M <shobanavalli@yahoo.com>
Subject: Will missing libraries lead to kernel panic?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I am trying to boot my board with 2.4.18 kernel. I am
getting the Kernel panic: No init found error when
tried with all kernels  above 2.4.8. But, in pc
environment,they are working fine. Why is this so? 
The distribution is Redhat 7.2. The 2.4.8 kernel, is
bringing the board up with the same rootfs.  
	
	The root file system is mounted.  The rootfs has
/sbin/init and /bin/sh. Init may not be corrupted,
since it is working with 2.4.8 and other lower
versions. 

	I tried including /initrd directory in the rootfs,
but that couldn't solve the problem. Am I missing any
libraries  needed for kernels above 2.4.8 in my
rootfs? Where can I get those details? As of now, all
files in  my rootfs /lib donot have executable
permission and are without symbolic links. Are these a
must for kernels above 2.4.8?
 
    ext3 is deselected in Kernel configuration. Does
ext3 file system has anything to do here? This kernel
panic problem persists even when the .config of 2.4.8
is used for configuring the kernel...Does the problem
lie in the kernel configuration or rootfs? 

Please enlighten me
Regards
Shobana


__________________________________________________
Do You Yahoo!?
Yahoo! Games - play chess, backgammon, pool and more
http://games.yahoo.com/
