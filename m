Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTIVXkD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbTIVXjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:39:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:5537 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262456AbTIVXam convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:42 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734242947@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734242958@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:24 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.16, 2003/09/22 13:10:15-07:00, greg@kroah.com

[PATCH] I2C: fix up dependancies in the i2c/busses/Kconfig file


 drivers/i2c/busses/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:13:27 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:13:27 2003
@@ -64,7 +64,7 @@
 
 config I2C_I810
 	tristate "Intel 810/815"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  810/815 family of mainboard I2C interfaces.  Specifically, the 
@@ -129,7 +129,7 @@
 
 config I2C_SAVAGE4
 	tristate "S3 Savage 4"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the 
 	  S3 Savage 4 I2C interface.
@@ -176,7 +176,7 @@
 
 config I2C_VIA
 	tristate "VIA 82C58B"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
 	help
 
 	  If you say yes to this option, support will be included for the VIA
@@ -205,7 +205,7 @@
 
 config I2C_VOODOO3
 	tristate "Voodoo 3"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
 	help
 
 	  If you say yes to this option, support will be included for the

