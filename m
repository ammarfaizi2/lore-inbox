Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLKCt2>; Sun, 10 Dec 2000 21:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLKCtS>; Sun, 10 Dec 2000 21:49:18 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:24334 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S129183AbQLKCtH>; Sun, 10 Dec 2000 21:49:07 -0500
Message-ID: <3A343923.A6602771@megapathdsl.net>
Date: Sun, 10 Dec 2000 18:17:07 -0800
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test12-pre8 -- ohci1394.c:1588 In function `alloc_dma_rcv_ctx': 
 structure has no member named `next'
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[2]: Entering directory `/usr/src/linux/drivers/ieee1394'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 -DMODULE  
-DEXPORT_SYMTAB -c ohci1394.c
ohci1394.c: In function `alloc_dma_rcv_ctx':
ohci1394.c:1588: structure has no member named `next'
{standard input}: Assembler messages:
{standard input}:20: Warning: Ignoring changed section attributes for
.modinfo
make[2]: *** [ohci1394.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/ieee1394'
make[1]: *** [_modsubdir_ieee1394] Error 2
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
