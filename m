Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284886AbRL2ALX>; Fri, 28 Dec 2001 19:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284905AbRL2ALN>; Fri, 28 Dec 2001 19:11:13 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:34829 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S284886AbRL2ALJ>; Fri, 28 Dec 2001 19:11:09 -0500
Subject: 2.5.1-dj7 -- fdomain.c: In function `do_fdomain_16x0_intr':
	`io_request_lock' undeclared
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2001.12.21.18.01 (Preview Release)
Date: 28 Dec 2001 16:12:20 -0800
Message-Id: <1009584742.22848.2.camel@stomata.megapathdsl.net>
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
../fdomain.c: In function `fdomain_16x0_release':
../fdomain.c:2045: warning: control reaches end of non-void function
make[3]: *** [fdomain.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/scsi/pcmcia'

