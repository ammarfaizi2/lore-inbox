Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSBKDnF>; Sun, 10 Feb 2002 22:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286962AbSBKDmz>; Sun, 10 Feb 2002 22:42:55 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:20487 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S286959AbSBKDmu>; Sun, 10 Feb 2002 22:42:50 -0500
Subject: fdomain.c:1568: structure has no member named `address'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 10 Feb 2002 19:39:50 -0800
Message-Id: <1013398791.30864.37.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE 
-DKBUILD_BASENAME=fdomain -DPCMCIA -D__NO_VERSION__ -c -o fdomain.o
../fdomain.c
../fdomain.c: In function `do_fdomain_16x0_intr':
../fdomain.c:1568: structure has no member named `address'
../fdomain.c:1601: structure has no member named `address'
../fdomain.c: In function `fdomain_16x0_queue':
../fdomain.c:1687: structure has no member named `address'
../fdomain.c: In function `fdomain_16x0_release':
../fdomain.c:2046: warning: control reaches end of non-void function

CONFIG_SCSI_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m


