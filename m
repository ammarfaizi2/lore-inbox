Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263759AbTCUSjY>; Fri, 21 Mar 2003 13:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263752AbTCUSiW>; Fri, 21 Mar 2003 13:38:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9604
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263743AbTCUShd>; Fri, 21 Mar 2003 13:37:33 -0500
Date: Fri, 21 Mar 2003 19:52:48 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211952.h2LJqmPq026091@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove __NO_VERSION__ from jffs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/jffs/intrep.c linux-2.5.65-ac2/fs/jffs/intrep.c
--- linux-2.5.65/fs/jffs/intrep.c	2003-02-15 03:39:32.000000000 +0000
+++ linux-2.5.65-ac2/fs/jffs/intrep.c	2003-03-14 00:52:26.000000000 +0000
@@ -55,7 +55,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/slab.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/jffs/jffs_fm.c linux-2.5.65-ac2/fs/jffs/jffs_fm.c
--- linux-2.5.65/fs/jffs/jffs_fm.c	2003-02-10 18:38:42.000000000 +0000
+++ linux-2.5.65-ac2/fs/jffs/jffs_fm.c	2003-03-14 00:52:26.000000000 +0000
@@ -16,7 +16,6 @@
  * Copyright (C) 2000  Alexander Larsson (alex@cendio.se), Cendio Systems AB
  *
  */
-#define __NO_VERSION__
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <linux/jffs.h>
