Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQLKIhg>; Mon, 11 Dec 2000 03:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130330AbQLKIh0>; Mon, 11 Dec 2000 03:37:26 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:34516 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S129464AbQLKIhL>;
	Mon, 11 Dec 2000 03:37:11 -0500
Date: Mon, 11 Dec 2000 19:06:36 +1100 (EST)
From: "Edward C. Lang" <edlang@pcug.org.au>
To: linux-kernel@vger.kernel.org
Subject: [2.4.0-test12-pre8] plip error.
Message-ID: <Pine.GSO.4.21.0012111904050.20898-100000@supreme.pcug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
/usr/local/src/linux/include/linux/modversions.h   -c -o plip.o plip.c
plip.c: In function `plip_init_dev':
plip.c:352: structure has no member named `next'
plip.c:357: structure has no member named `next'
plip.c:363: structure has no member named `next'
{standard input}: Assembler messages:
{standard input}:18: Warning: Ignoring changed section attributes for
.modinfo
make[3]: *** [plip.o] Error 1


-- 

Edward C. Lang   woot on various channels on irc.openprojects.net
edlang@pcug.org.au - Normal mail. Most stuff ends up here anyway.
edlang@debian.org  - Debian mail. Finger this address for keys.
woot@zork.net edlang@manuka.net - Other email addresses.    TINC.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
