Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317574AbSFIHbX>; Sun, 9 Jun 2002 03:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317576AbSFIHbW>; Sun, 9 Jun 2002 03:31:22 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:21258 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317574AbSFIHbV>; Sun, 9 Jun 2002 03:31:21 -0400
Subject: 2.5.21 -- sound/core/misc.c:93: `file' undeclared in function
	`snd_printd'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 09 Jun 2002 00:29:02 -0700
Message-Id: <1023607742.5775.7.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,.misc.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=misc   -c -o misc.o misc.c
misc.c: In function `snd_printd':
misc.c:93: `file' undeclared (first use in this function)
misc.c:93: (Each undeclared identifier is reported only once
misc.c:93: for each function it appears in.)
misc.c:93: `line' undeclared (first use in this function)
make[2]: *** [misc.o] Error 1
make[2]: Leaving directory `/usr/src/linux/sound/core'

CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y

#
# PCI devices
#
CONFIG_SND_EMU10K1=m


