Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311862AbSCTRSE>; Wed, 20 Mar 2002 12:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311863AbSCTRRz>; Wed, 20 Mar 2002 12:17:55 -0500
Received: from inti.inf.utfsm.cl ([146.83.198.3]:59812 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S311862AbSCTRRk>;
	Wed, 20 Mar 2002 12:17:40 -0500
Date: Wed, 20 Mar 2002 12:17:13 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Message-Id: <200203201617.g2KGHDkZ009635@tigger.valparaiso.cl>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19-pre3-ac3 compile failure
Cc: Alan.Cox@linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -DKBUILD_BASENAME=pppoe  -c -o pppoe.o pppoe.c
pppoe.c: In function `pppoe_flush_dev':
pppoe.c:282: `PPPOX_ZOMBIE' undeclared (first use in this function)
pppoe.c:282: (Each undeclared identifier is reported only once
pppoe.c:282: for each function it appears in.)
pppoe.c: In function `pppoe_disc_rcv':
pppoe.c:446: `PPPOX_ZOMBIE' undeclared (first use in this function)
pppoe.c: In function `pppoe_ioctl':
pppoe.c:730: `PPPOX_ZOMBIE' undeclared (first use in this function)
make[2]: *** [pppoe.o] Error 1
