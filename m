Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131651AbQLJWor>; Sun, 10 Dec 2000 17:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132345AbQLJWoh>; Sun, 10 Dec 2000 17:44:37 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:34834 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S131651AbQLJWo0>;
	Sun, 10 Dec 2000 17:44:26 -0500
Date: Sun, 10 Dec 2000 23:13:59 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200012102213.XAA27317@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12-pre8 (plip) does not compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i586 -DMODULE   -c -o plip.o plip.c
plip.c: In function `plip_init_dev':
plip.c:352: structure has no member named `next'
plip.c:357: structure has no member named `next'
plip.c:363: structure has no member named `next'
{standard input}: Assembler messages:
{standard input}:18: Warning: Ignoring changed section attributes for .modinfo
make[2]: *** [plip.o] Erreur 1
make[2]: Quitte le répertoire
`/usr/src/kernel-sources-2.4.0-test12-pre8/drivers/net'
make[1]: *** [_modsubdir_net] Erreur 2
make[1]: Quitte le répertoire
`/usr/src/kernel-sources-2.4.0-test12-pre8/drivers'
make: *** [_mod_drivers] Erreur 2


----
Regards
		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
