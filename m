Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbRLKWj3>; Tue, 11 Dec 2001 17:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284141AbRLKWjT>; Tue, 11 Dec 2001 17:39:19 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:60170 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S284143AbRLKWjN>; Tue, 11 Dec 2001 17:39:13 -0500
Subject: 2.5.1-pre10:  parport_cs.c:327: `LP_MAJOR' undeclared
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 11 Dec 2001 14:41:11 -0800
Message-Id: <1008110484.1619.2.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
parport_cs.o parport_cs.c
parport_cs.c: In function `parport_config':
parport_cs.c:327: `LP_MAJOR' undeclared (first use in this function)
parport_cs.c:327: (Each undeclared identifier is reported only once
parport_cs.c:327: for each function it appears in.)
parport_cs.c: At top level:
parport_cs.c:109: warning: `parport_cs_ops' defined but not used
make[2]: *** [parport_cs.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/parport'


