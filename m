Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264985AbSJPJYB>; Wed, 16 Oct 2002 05:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbSJPJYB>; Wed, 16 Oct 2002 05:24:01 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:50359 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S264985AbSJPJYA>; Wed, 16 Oct 2002 05:24:00 -0400
Subject: 2.5.43 -- media/video/stradis.c in function `saa_open':1949:
	structure has no member named `busy'
From: Miles Lane <miles.lane@attbi.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1034760289.3983.15.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 16 Oct 2002 02:24:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,drivers/media/video/.stradis.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -Iarch/i386/mach-generic -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=stradis   -c -o
drivers/media/video/stradis.o drivers/media/video/stradis.c
drivers/media/video/stradis.c: In function `saa_open':
drivers/media/video/stradis.c:1949: structure has no member named `busy'
drivers/media/video/stradis.c: In function `saa_close':
drivers/media/video/stradis.c:1961: structure has no member named `busy'

CONFIG_VIDEO_DEV=y

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
# CONFIG_VIDEO_BT848 is not set
CONFIG_VIDEO_PMS=y
CONFIG_VIDEO_BWQCAM=y
CONFIG_VIDEO_CQCAM=y
CONFIG_VIDEO_W9966=y
CONFIG_VIDEO_CPIA=y
# CONFIG_VIDEO_CPIA_PP is not set
CONFIG_VIDEO_CPIA_USB=y
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
CONFIG_VIDEO_STRADIS=y


