Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267279AbUHIVst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267279AbUHIVst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267292AbUHIVst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:48:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59360 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267279AbUHIVsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:48:20 -0400
Date: Mon, 9 Aug 2004 23:48:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small drivers/ide/legacy/Makefile cleanup
Message-ID: <20040809214809.GD26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Let's kill the obsolete CONFIG_BLK_DEV_HD98 entry.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc3-mm2-full/drivers/ide/legacy/Makefile.old	2004-08-09 23:47:02.000000000 +0200
+++ linux-2.6.8-rc3-mm2-full/drivers/ide/legacy/Makefile	2004-08-09 23:47:12.000000000 +0200
@@ -10,6 +10,5 @@
 
 # Last of all
 obj-$(CONFIG_BLK_DEV_HD)		+= hd.o
-obj-$(CONFIG_BLK_DEV_HD98)		+= hd98.o
 
 EXTRA_CFLAGS	:= -Idrivers/ide
