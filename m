Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289293AbSAVVXt>; Tue, 22 Jan 2002 16:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289306AbSAVVXl>; Tue, 22 Jan 2002 16:23:41 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:7438 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289293AbSAVVXa>; Tue, 22 Jan 2002 16:23:30 -0500
Subject: 2.5.3-pre3 -- fbdev.c:1814: In function `riva_set_fbinfo':
	incompatible types in assignment
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 22 Jan 2002 13:22:31 -0800
Message-Id: <1011734552.24310.10.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon     -c -o fbdev.o fbdev.c
fbdev.c: In function `riva_set_fbinfo':
fbdev.c:1814: incompatible types in assignment
make[4]: *** [fbdev.o] Error 1
make[4]: Leaving directory `/usr/src/linux/drivers/video/riva'

CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_8x16=y


