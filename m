Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271773AbTGROv1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271716AbTGROsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:48:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27781
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271794AbTGROI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:08:56 -0400
Date: Fri, 18 Jul 2003 15:23:16 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181423.h6IENGPV017794@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix jffs2 build
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Jamie Hicks)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/fs/jffs2/Makefile linux-2.6.0-test1-ac2/fs/jffs2/Makefile
--- linux-2.6.0-test1/fs/jffs2/Makefile	2003-07-10 21:06:05.000000000 +0100
+++ linux-2.6.0-test1-ac2/fs/jffs2/Makefile	2003-07-15 17:29:03.000000000 +0100
@@ -13,6 +13,7 @@
 
 LINUX_OBJS-24	:= super-v24.o crc32.o
 LINUX_OBJS-25	:= super.o
+LINUX_OBJS-26	:= super.o
 
 NAND_OBJS-$(CONFIG_JFFS2_FS_NAND)	:= wbuf.o
 
