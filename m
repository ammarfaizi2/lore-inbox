Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbTDJJ5P (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 05:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264017AbTDJJ5P (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 05:57:15 -0400
Received: from mailhub.compass.com.ph ([202.70.96.34]:20492 "HELO
	mailhub.compass.com.ph") by vger.kernel.org with SMTP
	id S264016AbTDJJ5O (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 05:57:14 -0400
Message-ID: <21047.202.70.96.36.1049969332.squirrel@www.compass.com.ph>
Date: Thu, 10 Apr 2003 18:08:52 +0800 (PHT)
Subject: i810_audio errors
From: "Robinson V. Escubil" <jojo.escubil@compass.com.ph>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Reply-To: jojo.escubil@compass.com.ph
X-Mailer: QwkNezMail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having errors with i810_audio when compiling patch-2.4.21-pre7

gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre7/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  
-nostdinc -iwithprefix include -DKBUILD_BASENAME=i810_audio  -c -o
i810_audio.o i810_audio.c
i810_audio.c: In function `i810_ac97_init':
i810_audio.c:2930: structure has no member named `modem'
i810_audio.c: In function `i810_probe':
i810_audio.c:3261: warning: label `out_chan' defined but not used
make[3]: *** [i810_audio.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.21-pre7/drivers/sound'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.21-pre7/drivers/sound'
make[1]: *** [_subdir_sound] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21-pre7/drivers'
make: *** [_dir_drivers] Error 2

===============================
Robinson V. Escubil
Network Administrator
Compass Internet Inc.
24/F Robinsons Galleria
Corporate Center Building,
EDSA corner Ortigas Avenue,
Quezon City, Philippines 1605
ICQ. No. 20446716
Cell.    9195862166
Tel. No. 6335252 * 6385773 * 6382596
Fax. No. 6345813

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GIT/J d++ s+:+>: a- C+++(++++)$ UL+++ P+ L++ E---
W++ N+ o+ K- w O M V-- PS PE- Y+ PGP- t+ 5 X+ R+
tv b+ DI D+ G e++ h! r+++ y+++
------END GEEK CODE BLOCK------




