Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTI2RRU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTI2RGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:06:37 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:43447 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263803AbTI2RE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:04:59 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] VIA Typo in i2c.
Message-Id: <E1A41Rq-0000NA-00@hardwired>
Date: Mon, 29 Sep 2003 18:04:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/i2c/busses/Kconfig linux-2.5/drivers/i2c/busses/Kconfig
--- bk-linus/drivers/i2c/busses/Kconfig	2003-09-23 07:32:23.000000000 +0100
+++ linux-2.5/drivers/i2c/busses/Kconfig	2003-09-29 03:48:20.000000000 +0100
@@ -285,7 +285,7 @@ config I2C_VELLEMAN
 	  will be called i2c-velleman.
 
 config I2C_VIA
-	tristate "VIA 82C58B"
+	tristate "VIA 82C586B"
 	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
 	help
 
