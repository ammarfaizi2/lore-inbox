Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTB0WxD>; Thu, 27 Feb 2003 17:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbTB0WxD>; Thu, 27 Feb 2003 17:53:03 -0500
Received: from [62.37.236.142] ([62.37.236.142]:59276 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id <S267244AbTB0WxC>;
	Thu, 27 Feb 2003 17:53:02 -0500
Message-ID: <3E5E9876.3040306@wanadoo.es>
Date: Fri, 28 Feb 2003 00:00:06 +0100
From: =?ISO-8859-1?Q?Xos=C9_Vazquez?= <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre5 error
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

--cortamorena--
make[2]: Entering directory `/datos/kernel/linux/drivers/ieee1394'
ld -m elf_i386 -e stext -r -o ieee1394.o ieee1394_core.o
ieee1394_transactions.o hosts.o highlevel.o
 csr.o nodemgr.o dma.o
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-str
ict-aliasing -fno-common -fomit-frame-pointer -pipe
-mpreferred-stack-boundary=2 -march=athlon -DMOD
ULE -DMODVERSIONS -include
/datos/kernel/linux/include/linux/modversions.h  -nostdinc -iwithprefix
include -DKBUILD_BASENAME=raw1394  -c -o raw1394.o raw1394.c
In file included from raw1394.c:50:
raw1394.h:167: field `tq' has incomplete type
raw1394.c: In function `__alloc_pending_request':
raw1394.c:110: warning: implicit declaration of function `HPSB_INIT_WORK'
raw1394.c: In function `handle_iso_send':
raw1394.c:800: warning: implicit declaration of function `HPSB_PREPARE_WORK'
make[2]: *** [raw1394.o] Error 1
make[2]: Leaving directory `/datos/kernel/linux/drivers/ieee1394'
make[1]: *** [_modsubdir_ieee1394] Error 2
make[1]: Leaving directory `/datos/kernel/linux/drivers'
mak: *** [_mod_drivers] Error 2
--end--

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!

