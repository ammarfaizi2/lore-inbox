Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135594AbREEXeM>; Sat, 5 May 2001 19:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135595AbREEXeC>; Sat, 5 May 2001 19:34:02 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:15880 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135594AbREEXdw>; Sat, 5 May 2001 19:33:52 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105052334.BAA22885@green.mif.pg.gda.pl>
Subject: [PATCH] for koi8-u  in 2.4.4-ac5
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 6 May 2001 01:34:02 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I think this patch requires no comment.


diff -ur linux-2.4.4-ac5/fs/nls/nls_koi8-u.c linux/fs/nls/nls_koi8-u.c
--- linux-2.4.4-ac5/fs/nls/nls_koi8-u.c	Sat May  5 11:30:21 2001
+++ linux/fs/nls/nls_koi8-u.c	Sun May  6 01:03:37 2001
@@ -141,6 +141,7 @@
 	0xd2, 0xd3, 0xd4, 0xd5, 0xc6, 0xc8, 0xc3, 0xde, /* 0x40-0x47 */
 	0xdb, 0xdd, 0xdf, 0xd9, 0xd8, 0xdc, 0xc0, 0xd1, /* 0x48-0x4f */
 	0x00, 0xa3, 0x00, 0x00, 0xa4, 0x00, 0xa6, 0xa7, /* 0x50-0x57 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x58-0x5f */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x60-0x67 */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x68-0x6f */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x70-0x77 */


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
