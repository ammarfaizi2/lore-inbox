Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289297AbSBJFkG>; Sun, 10 Feb 2002 00:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289293AbSBJFj4>; Sun, 10 Feb 2002 00:39:56 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:41736 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289297AbSBJFjl>; Sun, 10 Feb 2002 00:39:41 -0500
Subject: 2.5.4-pre5 -- fbdev.c:1814: incompatible types in assignment in
	function `riva_set_fbinfo'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 09 Feb 2002 21:36:36 -0800
Message-Id: <1013319396.28886.8.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make[4]: Entering directory `/usr/src/linux/drivers/video/riva'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon   
-DKBUILD_BASENAME=fbdev  -c -o fbdev.o fbdev.c
fbdev.c: In function `riva_set_fbinfo':
fbdev.c:1814: incompatible types in assignment
make[4]: *** [fbdev.o] Error 1
make[4]: Leaving directory `/usr/src/linux/drivers/video/riva'

CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y


