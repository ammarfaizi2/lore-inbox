Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVEQQRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVEQQRD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVEQQN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:13:27 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:9487 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261738AbVEQQJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:09:34 -0400
Date: Tue, 17 May 2005 18:09:36 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Alexey Fisher <fishor@gmx.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] I2C: chips/Kconfig corrections
Message-Id: <20050517180936.4717aabf.khali@linux-fr.org>
In-Reply-To: <200505170830.16998.fishor@gmx.net>
References: <200505170830.16998.fishor@gmx.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

I had to slightly modify your original patch to have it apply properly.
I also stripped the trailing white space. Here comes the modified
version.

Greg, please apply to your i2c tree.

---

Here are some corrections for drivers/i2c/chips/Kconfig.

Signed-off-by: Alexey Fisher <fishor@gmx.net>
Signed-off-by: Jean Delvare <khali@linux-fr.org>


 drivers/i2c/chips/Kconfig |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc4.orig/drivers/i2c/chips/Kconfig	2005-05-16 22:51:53.000000000 +0200
+++ linux-2.6.12-rc4/drivers/i2c/chips/Kconfig	2005-05-17 18:04:23.000000000 +0200
@@ -29,6 +29,7 @@
 	help
 	  If you say yes here you get support for Analog Devices ADM1025
 	  and Philips NE1619 sensor chips.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1025.
 
@@ -38,6 +39,8 @@
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Analog Devices ADM1026
+	  sensor chip.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1026.
 
@@ -48,6 +51,7 @@
 	help
 	  If you say yes here you get support for Analog Devices ADM1031 
 	  and ADM1030 sensor chips.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1031.
 
@@ -198,8 +202,7 @@
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM78,
-	  LM78-J and LM79.  This can also be built as a module which can be
-	  inserted and removed while the kernel is running.
+	  LM78-J and LM79.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm78.
@@ -232,7 +235,7 @@
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM85
-	  sensor chips and clones: ADT7463 and ADM1027.
+	  sensor chips and clones: ADT7463, EMC6D100, EMC6D102 and ADM1027.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm85.



-- 
Jean Delvare
