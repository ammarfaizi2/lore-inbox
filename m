Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263739AbTDGXay (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTDGXab (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:30:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9857
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263829AbTDGXQc (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:16:32 -0400
Date: Tue, 8 Apr 2003 01:35:27 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080035.h380ZRX7009239@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: continued compatmac exterminations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/mtd/compatmac.h linux-2.5.67-ac1/include/linux/mtd/compatmac.h
--- linux-2.5.67/include/linux/mtd/compatmac.h	2003-04-08 00:37:39.000000000 +0100
+++ linux-2.5.67-ac1/include/linux/mtd/compatmac.h	2003-04-04 00:03:46.000000000 +0100
@@ -17,7 +17,6 @@
 #ifndef __LINUX_MTD_COMPATMAC_H__
 #define __LINUX_MTD_COMPATMAC_H__
 
-#include <linux/compatmac.h>
 #include <linux/types.h> /* used later in this header */
 #include <linux/module.h>
 #ifndef LINUX_VERSION_CODE
