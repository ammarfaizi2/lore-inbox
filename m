Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLKC7r>; Sun, 10 Dec 2000 21:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLKC7i>; Sun, 10 Dec 2000 21:59:38 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:48901 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129345AbQLKC73>;
	Sun, 10 Dec 2000 21:59:29 -0500
Message-Id: <200012110132.eBB1Wlf21339@sleipnir.valparaiso.cl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0t12p8: Fails building drivers/net/plip.o as module
X-Mailer: MH [Version 6.8.4]
Date: Sun, 10 Dec 2000 22:32:46 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct (as per AC's md5sum) patch applied. i686, RH 7, kgcc:

kgcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 -DMODULE   -c -o plip.o plip.c
plip.c: In function `plip_init_dev':
plip.c:352: structure has no member named `next'
plip.c:357: structure has no member named `next'
plip.c:363: structure has no member named `next'
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
