Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130457AbQKHJYc>; Wed, 8 Nov 2000 04:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130544AbQKHJYW>; Wed, 8 Nov 2000 04:24:22 -0500
Received: from [202.103.134.10] ([202.103.134.10]:34244 "HELO mx1.netease.com")
	by vger.kernel.org with SMTP id <S130543AbQKHJYJ>;
	Wed, 8 Nov 2000 04:24:09 -0500
Date: Wed, 8 Nov 2000 17:24:30 +0800
From: Nick Cheng <grandsolo@netease.com>
Reply-To: grandsolo@sina.com
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Unable to mount fs : kernel 2.4.0-test11
Organization: Lejie Network Service Co. Ltd
X-mailer: FoxMail 3.0 beta 2 [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20001108092858.65D911C745B6B@mx1.netease.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Dear sirs,
   I've found I not the only one who find something's wrong with new kernel.
   That is , When I build kernel 2.4.0-test9 on my PC with IDE disk , It's
all OK.
   But When I build it on DELL 6450, SCSI/RAID on it, It's wrong.
   When I use Redhat 6.2 , or when I build 2.2.17, everything's OK. all the
modules I need to add to the kernel is eppro100.o for NIC , aix7xxx.o for
SCSI and megaraid.o for RAID.
   But when I download 2.4.0-test9, and config it with the same configuation
with before, It's wrong. it tell me:
   ....
Megaraid : v107 (December 22.1999)
Megaraid : found 0x8086:0x1960: in 03:0b.1
Megaraid : board configured for I2O,ignoring this card .Reconfigure the
card.
Medaraid : in the BIOS for "mass storage" to use it with this driver.
VFS : Cannot open root device "801" or 08:01
Please append a correct "root=" boot option
Kernel panic :VFS:Unable to mount root fs on 08:01

..
and system halted. I don't know what to do. I've selected the Ramdisk ,the
support of I2O, and not use the modules in the new kernel, I add all of the
modules into kernel. but nothing happened.
(when I try to rpm to new kernel from Redhat 7.0 by using the disc2, it's
all the same.)
Is there anybody can tell us something? thanks a lot!
if I cannot solve the problem, they'll choose the D- Windows 2k. I don't
wanna see it happened.
the most important thing is to make the Linux support 4GB RAM. is there any
other way except for waiting for the stable 2.4.0? thanks a lot!

   yours sincerely,
         Nick Cheng



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
