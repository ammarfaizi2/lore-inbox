Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291169AbSBGPQ2>; Thu, 7 Feb 2002 10:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291170AbSBGPQW>; Thu, 7 Feb 2002 10:16:22 -0500
Received: from [65.169.83.229] ([65.169.83.229]:54921 "EHLO
	hst000004380um.kincannon.olemiss.edu") by vger.kernel.org with ESMTP
	id <S291169AbSBGPQG>; Thu, 7 Feb 2002 10:16:06 -0500
Date: Thu, 7 Feb 2002 09:15:18 -0600
From: Benjamin Pharr <ben@benpharr.com>
To: linux-kernel@vger.kernel.org
Subject: inode.c Compile Error
Message-ID: <20020207151518.GA5184@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.18-pre8
X-PGP-ID: 0x6859792C
X-PGP-Key: http://www.benpharr.com/public_key.asc
X-PGP-Fingerprint: 7BF0 E432 3365 C1FC E0E3  0BE2 44E1 3E1E 6859 792C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error when trying to compile 2.5.4-pre2:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.4-pre2/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o inode.o inode.c
inode.c: In function `usb_get_sb':
inode.c:528: `usb_fill_super' undeclared (first use in this function)
inode.c:528: (Each undeclared identifier is reported only once
inode.c:528: for each function it appears in.)
inode.c: At top level:
inode.c:368: warning: `usbfs_fill_super' defined but not used
make[3]: *** [inode.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.4-pre2/drivers/usb'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.4-pre2/drivers/usb'
make[1]: *** [_subdir_usb] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.4-pre2/drivers'
make: *** [_dir_drivers] Error 2
benix:/usr/src/linux-2.5.4-pre2# 

Ben Pharr
ben@benpharr.com

