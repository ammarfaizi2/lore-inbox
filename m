Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUCPDAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 22:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbUCPC7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 21:59:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:23471 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262899AbUCPAC1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:27 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913905@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:30 -0800
Message-Id: <10793913904022@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.5, 2004/02/17 14:42:07-08:00, bunk@fs.tum.de

[PATCH] I2C: update I2C help text

VIDEO_BT848 selects I2C_ALGOBIT.


 drivers/i2c/Kconfig |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Mar 15 14:37:36 2004
+++ b/drivers/i2c/Kconfig	Mon Mar 15 14:37:36 2004
@@ -15,9 +15,6 @@
 
 	  Both I2C and SMBus are supported here. You will need this for
 	  hardware sensors support, and also for Video For Linux support.
-	  Specifically, if you want to use a BT848 based frame grabber/overlay
-	  boards under Linux, say Y here and also to "I2C bit-banging
-	  interfaces", below.
 
 	  If you want I2C support, you should say Y here and also to the
 	  specific driver for your bus adapter(s) below.

