Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRB1XDz>; Wed, 28 Feb 2001 18:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129344AbRB1XDq>; Wed, 28 Feb 2001 18:03:46 -0500
Received: from mail.buylink.com ([63.203.87.2]:8200 "EHLO mail.buylink.com")
	by vger.kernel.org with ESMTP id <S129324AbRB1XDb>;
	Wed, 28 Feb 2001 18:03:31 -0500
Message-Id: <5.0.2.1.0.20010228140411.02475e38@ns1.kenjim.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 28 Feb 2001 15:02:19 -0800
To: linux-kernel@vger.kernel.org
From: james@game-hunter.com
Subject: STL2 onboard Adaptec controller problems with Kernel 2.4.2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I recently tried to upgrade to the 2.4.2 kernel from the 2.2.x kernels on a 
STL2 motherboard and it appears the kernel can not detect the onboard SCSI 
controller.  I have even tried the patches from 
http://people.freebsd.org/~gibbs/linux/ to bring the aic module up to 6.1.4 
with still no luck.  Has anyone gotten this to work?

I get the following error during booting when I compile the aic7xxx as a 
module.  I have also tried compiling it into the kernel with no luck.

Loading aic7xxx module
/lib/aic7xxx.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters
ERROR: insmod exited abnormally
kmod: failed to exec /sbin/modprob -s -k block-major-8, errno=2
VFS: Cannot open root device "802" or 08:02
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:02

The system is configured as follows

Intel STL2 motherboard.
2x1GHz PIII
512MB Ram
IDE CDROM drive
Segate ST318451LW 18.2GB ULTRA160 HD
Redhat 7.0 with all updates
updated modutils to the latest version.
Full Reiser FS


Any ideas anyone?
--James

