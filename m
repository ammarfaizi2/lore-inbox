Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbRALI6c>; Fri, 12 Jan 2001 03:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbRALI6W>; Fri, 12 Jan 2001 03:58:22 -0500
Received: from [213.97.45.174] ([213.97.45.174]:62698 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S130067AbRALI6E>;
	Fri, 12 Jan 2001 03:58:04 -0500
Date: Fri, 12 Jan 2001 09:57:54 +0100 (CET)
From: Pau <linux4u@wanadoo.es>
To: <linux-kernel@vger.kernel.org>
Subject: error compiling 2.4.1-pre3
Message-ID: <Pine.LNX.4.30.0101120956240.1297-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
/usr/src/linux/include/linux/modversions.h   -DEXPORT_SYMTAB -c xor.c
In file included from /usr/src/linux/include/linux/raid/md.h:51,
                 from xor.c:22:
/usr/src/linux/include/linux/raid/md_k.h: In function `pers_to_level':
/usr/src/linux/include/linux/raid/md_k.h:39: warning: control reaches end
of non-void function
xor.c: In function `calibrate_xor_block':
xor.c:118: `HAVE_XMM' undeclared (first use in this function)
xor.c:118: (Each undeclared identifier is reported only once
xor.c:118: for each function it appears in.)
{standard input}: Assembler messages:
{standard input}:8: Warning: Ignoring changed section attributes for
.modinfo
make[2]: *** [xor.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/md'
make[1]: *** [_modsubdir_md] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

 Pau

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
