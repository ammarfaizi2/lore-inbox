Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286942AbSBKDYF>; Sun, 10 Feb 2002 22:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSBKDXz>; Sun, 10 Feb 2002 22:23:55 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:32019 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S286942AbSBKDXm>; Sun, 10 Feb 2002 22:23:42 -0500
Subject: 2.5.4-pre6 -- qlogicfas.c:394: In function `ql_pcmd': structure has
	no member named `address'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 10 Feb 2002 19:20:28 -0800
Message-Id: <1013397629.30865.35.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE 
-DKBUILD_BASENAME=qlogicfas -DPCMCIA -D__NO_VERSION__ -c -o qlogicfas.o
../qlogicfas.c
../qlogicfas.c: In function `ql_pcmd':
../qlogicfas.c:394: structure has no member named `address'

CONFIG_SCSI_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_PCMCIA_QLOGIC=m

