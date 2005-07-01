Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVGAWyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVGAWyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 18:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVGAWyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 18:54:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16145 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261618AbVGAWyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 18:54:43 -0400
Date: Sat, 2 Jul 2005 00:54:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [2.6 patch] drivers/ide/Makefile: kill dead CONFIG_BLK_DEV_IDE_TCQ entry
Message-ID: <20050701225442.GB3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch kills the dead CONFIG_BLK_DEV_IDE_TCQ entry.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-mm2-full/drivers/ide/Makefile.old	2005-07-01 00:46:38.000000000 +0200
+++ linux-2.6.12-mm2-full/drivers/ide/Makefile	2005-07-01 00:46:45.000000000 +0200
@@ -20,7 +20,6 @@
 # Core IDE code - must come before legacy
 ide-core-$(CONFIG_BLK_DEV_IDEPCI)	+= setup-pci.o
 ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+= ide-dma.o
-ide-core-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-core-$(CONFIG_PROC_FS)		+= ide-proc.o
 ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 

