Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289365AbSBNCUf>; Wed, 13 Feb 2002 21:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289367AbSBNCUY>; Wed, 13 Feb 2002 21:20:24 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:34061 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289365AbSBNCUG>; Wed, 13 Feb 2002 21:20:06 -0500
Subject: 2.5.5-pre1 -- rd.c:271: In function `rd_make_request': too many
	arguments to function
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 13 Feb 2002 18:16:39 -0800
Message-Id: <1013653000.1574.4.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon   
-DKBUILD_BASENAME=rd  -c -o rd.o rd.c
rd.c: In function `rd_make_request':
rd.c:271: too many arguments to function
make[3]: *** [rd.o] Error 1

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y


