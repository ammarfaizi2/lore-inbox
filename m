Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317271AbSFCEzH>; Mon, 3 Jun 2002 00:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317272AbSFCEzG>; Mon, 3 Jun 2002 00:55:06 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:64517 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317271AbSFCEzF>; Mon, 3 Jun 2002 00:55:05 -0400
Subject: 2.5.20 -- raid5.c:1247: `tq_disk' undeclared
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 02 Jun 2002 21:53:14 -0700
Message-Id: <1023079994.1685.19.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon    
-DKBUILD_BASENAME=raid5  -c -o raid5.o raid5.c
raid5.c: In function `raid5_plug_device':
raid5.c:1247: `tq_disk' undeclared (first use in this function)
raid5.c:1247: (Each undeclared identifier is reported only once
raid5.c:1247: for each function it appears in.)
raid5.c: In function `run':
raid5.c:1589: sizeof applied to an incomplete type
make[2]: *** [raid5.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/md'

CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_MD_MULTIPATH=y
CONFIG_BLK_DEV_LVM=y


