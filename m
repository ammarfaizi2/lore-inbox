Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263730AbTCUSYm>; Fri, 21 Mar 2003 13:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263727AbTCUSXs>; Fri, 21 Mar 2003 13:23:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49795
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263713AbTCUSWg>; Fri, 21 Mar 2003 13:22:36 -0500
Date: Fri, 21 Mar 2003 19:37:51 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211937.h2LJbplD025845@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove __NO_VERSION__ from radio drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/radio/miropcm20-rds-core.c linux-2.5.65-ac2/drivers/media/radio/miropcm20-rds-core.c
--- linux-2.5.65/drivers/media/radio/miropcm20-rds-core.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/radio/miropcm20-rds-core.c	2003-03-14 00:52:15.000000000 +0000
@@ -13,8 +13,6 @@
  *        RDS support for MiroSound PCM20 radio
  */
 
-#define _NO_VERSION_
-
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/string.h>
