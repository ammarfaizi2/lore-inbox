Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279994AbRKISia>; Fri, 9 Nov 2001 13:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279997AbRKISiT>; Fri, 9 Nov 2001 13:38:19 -0500
Received: from wks121.navicsys.com ([207.180.73.121]:43891 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S279994AbRKISiM>; Fri, 9 Nov 2001 13:38:12 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.13 pcd problems?
From: Nick Papadonis <nick@coelacanth.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Date: 09 Nov 2001 13:38:05 -0500
Message-ID: <m3y9lfiycy.fsf@localhost.localdomain>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone having similar problems with pcd using Kernel v2.4.13?  I'm trying
to get my BackPack 6 working.  I don't think I should be passing any
other parameters to pcd.

Any insight much appreciated.

- Nick

$ 540 /home/nick -> modprobe paride
$ 541 /home/nick -> modprobe bpck6
$ 542 /home/nick -> modprobe pcd
/lib/modules/2.4.13/kernel/drivers/block/paride/pcd.o: init_module: Operation not permitted
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.13/kernel/drivers/block/paride/pcd.o: insmod /lib/modules/2.4.13/kernel/drivers/block/paride/pcd.o failed
/lib/modules/2.4.13/kernel/drivers/block/paride/pcd.o: insmod pcd failed


I get the following:
$ 539 /home/nick -> lsmod
Module                  Size  Used by
i810_audio             18032   0  (autoclean)
ac97_codec              9376   0  (autoclean) [i810_audio]
soundcore               3984   3  (autoclean) [i810_audio]
i810                   65248   1 
agpgart                17312   7  (autoclean)
autofs                  9504   0  (autoclean) (unused)
e100                   60720   1 
usb-uhci               22176   0  (unused)
usbcore                51744   1  [usb-uhci]

-- 
Nick
