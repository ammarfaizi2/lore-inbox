Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285092AbRLLIK7>; Wed, 12 Dec 2001 03:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285093AbRLLIKt>; Wed, 12 Dec 2001 03:10:49 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:21510 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S285092AbRLLIKa>; Wed, 12 Dec 2001 03:10:30 -0500
Subject: 2.5.1-pre10: Compilation failure in fdomain.c:1268:
	`io_request_lock' undeclared
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 12 Dec 2001 00:12:21 -0800
Message-Id: <1008144756.20180.0.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE  -DPCMCIA
-D__NO_VERSION__ -c -o fdomain.o ../fdomain.c
../fdomain.c: In function `do_fdomain_16x0_intr':
../fdomain.c:1268: `io_request_lock' undeclared (first use in this
function)
../fdomain.c:1268: (Each undeclared identifier is reported only once
../fdomain.c:1268: for each function it appears in.)
make[3]: *** [fdomain.o] Error 1

CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_CONSTANTS=y

CONFIG_SCSI_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m


