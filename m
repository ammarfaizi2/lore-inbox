Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283567AbRK3Ity>; Fri, 30 Nov 2001 03:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283568AbRK3Ito>; Fri, 30 Nov 2001 03:49:44 -0500
Received: from sdsl-216-36-113-151.dsl.sea.megapath.net ([216.36.113.151]:16098
	"EHLO stomata.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S283567AbRK3Ite>; Fri, 30 Nov 2001 03:49:34 -0500
Subject: 2.5.0-pre4 -- parport_cs.c: In function `parport_config':
	`LP_MAJOR' undeclared
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Nov 2001 00:48:11 -0800
Message-Id: <1007110091.25394.10.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o parport_cs.o parport_cs.c
parport_cs.c: In function `parport_config':
parport_cs.c:327: `LP_MAJOR' undeclared (first use in this function)
parport_cs.c:327: (Each undeclared identifier is reported only once
parport_cs.c:327: for each function it appears in.)
parport_cs.c: At top level:
parport_cs.c:109: warning: `parport_cs_ops' defined but not used
make[2]: *** [parport_cs.o] Error 1

CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y

