Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbUBONq4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 08:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUBONq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 08:46:56 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20425 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264905AbUBONqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 08:46:55 -0500
Date: Sun, 15 Feb 2004 14:46:50 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: [2.6 patch] update I2C help text
Message-ID: <20040215134649.GV1308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VIDEO_BT848 selects I2C_ALGOBIT.

cu
Adrian

--- linux-2.6.3-rc3-full/drivers/i2c/Kconfig.old	2004-02-15 14:44:05.000000000 +0100
+++ linux-2.6.3-rc3-full/drivers/i2c/Kconfig	2004-02-15 14:44:24.000000000 +0100
@@ -15,9 +15,6 @@
 
 	  Both I2C and SMBus are supported here. You will need this for
 	  hardware sensors support, and also for Video For Linux support.
-	  Specifically, if you want to use a BT848 based frame grabber/overlay
-	  boards under Linux, say Y here and also to "I2C bit-banging
-	  interfaces", below.
 
 	  If you want I2C support, you should say Y here and also to the
 	  specific driver for your bus adapter(s) below.
