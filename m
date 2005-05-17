Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVEQGbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVEQGbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 02:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVEQGbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 02:31:06 -0400
Received: from pop.gmx.de ([213.165.64.20]:10418 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261219AbVEQGax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 02:30:53 -0400
X-Authenticated: #23875046
From: Alexey Fisher <fishor@gmx.net>
Reply-To: fishor@gmx.net
To: Jean Delvare <khali@linux-fr.org>
Subject: drivers/i2c/chips/Kconfig patch. Format corection.
Date: Tue, 17 May 2005 08:30:16 +0200
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505170830.16998.fishor@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By Alexey Fisher <fishor@gmx.net>
Hi here is some format corretions for drivers/i2c/chips/Kconfig .
Best regards. 



diff -uprN linux/drivers/i2c/chips/Kconfig linux-2.6-dev/drivers/i2c/chips/Kconfig
--- linux/drivers/i2c/chips/Kconfig	2005-05-15 22:49:31.000000000 +0200
+++ linux-2.6-dev/drivers/i2c/chips/Kconfig	2005-05-15 22:58:28.000000000 +0200
@@ -29,6 +29,7 @@ config SENSORS_ADM1025
 	help
 	  If you say yes here you get support for Analog Devices ADM1025
 	  and Philips NE1619 sensor chips.
+	  
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1025.
 
@@ -38,6 +39,7 @@ config SENSORS_ADM1026
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Analog Devices ADM1026
+	  sensor chip.
+	  
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1026.
 
@@ -48,6 +50,7 @@ config SENSORS_ADM1031
 	help
 	  If you say yes here you get support for Analog Devices ADM1031 
 	  and ADM1030 sensor chips.
+	  
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1031.
 
@@ -198,8 +201,7 @@ config SENSORS_LM78
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM78,
-	  LM78-J and LM79.  This can also be built as a module which can be
-	  inserted and removed while the kernel is running.
+	  LM78-J and LM79.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm78.
@@ -232,7 +234,7 @@ config SENSORS_LM85
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM85
-	  sensor chips and clones: ADT7463 and ADM1027.
+	  sensor chips and clones: ADT7463, EMC6D100, EMC6D102 and ADM1027.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm85.
