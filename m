Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbSBKAqi>; Sun, 10 Feb 2002 19:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbSBKAps>; Sun, 10 Feb 2002 19:45:48 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:18957 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S285747AbSBKAp2>; Sun, 10 Feb 2002 19:45:28 -0500
Subject: 2.5.4-pre5 -- lvm.c:1310: In function `lvm_do_lock_lvm': structure
	has no member named `sigpending'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 10 Feb 2002 16:42:30 -0800
Message-Id: <1013388150.30864.22.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
CONFIG_BLK_DEV_LVM=m

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE 
-DKBUILD_BASENAME=lvm  -c -o lvm.o lvm.c
lvm.c: In function `lvm_do_lock_lvm':
lvm.c:1310: structure has no member named `sigpending'


