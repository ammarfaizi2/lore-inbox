Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289711AbSAWHki>; Wed, 23 Jan 2002 02:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289712AbSAWHk2>; Wed, 23 Jan 2002 02:40:28 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:5649 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289711AbSAWHkR>; Wed, 23 Jan 2002 02:40:17 -0500
Subject: 2.5.2-pre3 -- parport_cs.c:327: In function `parport_config':
	`LP_MAJOR' undeclared (first use in this function)
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 22 Jan 2002 23:39:12 -0800
Message-Id: <1011771555.28121.0.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o parport_cs.o parport_cs.c
parport_cs.c: In function `parport_config':
parport_cs.c:327: `LP_MAJOR' undeclared (first use in this function)
parport_cs.c:327: (Each undeclared identifier is reported only once
parport_cs.c:327: for each function it appears in.)
parport_cs.c: At top level:
parport_cs.c:109: warning: `parport_cs_ops' defined but not used
make[2]: *** [parport_cs.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/parport'


