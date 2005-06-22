Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbVFVGhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbVFVGhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVFVGd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:33:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:25244 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262796AbVFVFWE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:04 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: chips/Kconfig corrections
In-Reply-To: <1119417464710@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:45 -0700
Message-Id: <11194174653972@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: chips/Kconfig corrections

Here are some corrections for drivers/i2c/chips/Kconfig.

Signed-off-by: Alexey Fisher <fishor@gmx.net>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 057923f0f5ba346fc128ae0a1c3842d8c12bd7f0
tree 6c9cc5d15b6164988c0cb4a994cd22a8d45983c5
parent 6afe15595031bb9801af6207feed0bafc25b6e6b
author Jean Delvare <khali@linux-fr.org> Tue, 17 May 2005 18:09:36 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:58 -0700

 drivers/i2c/chips/Kconfig |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -29,6 +29,7 @@ config SENSORS_ADM1025
 	help
 	  If you say yes here you get support for Analog Devices ADM1025
 	  and Philips NE1619 sensor chips.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1025.
 
@@ -38,6 +39,8 @@ config SENSORS_ADM1026
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Analog Devices ADM1026
+	  sensor chip.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1026.
 
@@ -48,6 +51,7 @@ config SENSORS_ADM1031
 	help
 	  If you say yes here you get support for Analog Devices ADM1031 
 	  and ADM1030 sensor chips.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1031.
 
@@ -198,8 +202,7 @@ config SENSORS_LM78
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM78,
-	  LM78-J and LM79.  This can also be built as a module which can be
-	  inserted and removed while the kernel is running.
+	  LM78-J and LM79.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm78.
@@ -232,7 +235,7 @@ config SENSORS_LM85
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM85
-	  sensor chips and clones: ADT7463 and ADM1027.
+	  sensor chips and clones: ADT7463, EMC6D100, EMC6D102 and ADM1027.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm85.

