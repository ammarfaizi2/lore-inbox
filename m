Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135318AbRDVVTN>; Sun, 22 Apr 2001 17:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135335AbRDVVTD>; Sun, 22 Apr 2001 17:19:03 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:60939 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135318AbRDVVS4>; Sun, 22 Apr 2001 17:18:56 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200104222119.XAA04028@green.mif.pg.gda.pl>
Subject: [PATCH] cmsfs 2.4.3-ac12 compile fix
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 22 Apr 2001 23:19:08 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

cmsfs does not compile without this fix.

Andrzej

diff -ur linux-2.4.3-ac12/fs/cmsfs/cmsfsvfs.c linux/fs/cmsfs/cmsfsvfs.c
--- linux-2.4.3-ac12/fs/cmsfs/cmsfsvfs.c	Sun Apr 22 14:48:52 2001
+++ linux/fs/cmsfs/cmsfsvfs.c	Sun Apr 22 16:18:40 2001
@@ -26,6 +26,7 @@
 #include        <linux/mm.h>
 #include        <linux/locks.h>
 #include	<linux/init.h>
+#include	<linux/blkdev.h>
 
 #include        <asm/uaccess.h>
  


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
