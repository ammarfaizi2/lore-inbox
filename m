Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262745AbTCUUCx>; Fri, 21 Mar 2003 15:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263859AbTCUUBl>; Fri, 21 Mar 2003 15:01:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60292
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263858AbTCUTc1>; Fri, 21 Mar 2003 14:32:27 -0500
Date: Fri, 21 Mar 2003 20:47:42 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212047.h2LKlgeZ026497@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: add ide-default to the build
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/Makefile linux-2.5.65-ac2/drivers/ide/Makefile
--- linux-2.5.65/drivers/ide/Makefile	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/Makefile	2003-03-18 17:14:47.000000000 +0000
@@ -12,7 +12,7 @@
 
 # Core IDE code - must come before legacy
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-io.o ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-io.o ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-default.o
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
