Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318793AbSHLSF4>; Mon, 12 Aug 2002 14:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318792AbSHLSFz>; Mon, 12 Aug 2002 14:05:55 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:16799 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S318791AbSHLSFy>; Mon, 12 Aug 2002 14:05:54 -0400
Subject: [PATCH] 2.5.31 add two help texts to drivers/i2c/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 12 Aug 2002 12:06:49 -0600
Message-Id: <1029175609.2045.54.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds two help texts to drivers/i2c/Config.help for
CONFIG_ITE_I2C_ALGO and CONFIG_ITE_I2C_ADAP.

This has been in the -dj tree since about 2.5.7.
The text was obtained from ESR's v2.97 Configure.help.

Steven

--- linux-2.5.31/drivers/i2c/Config.help.orig	Mon Aug 12 11:44:52 2002
+++ linux-2.5.31/drivers/i2c/Config.help	Mon Aug 12 11:45:20 2002
@@ -80,6 +80,26 @@
   <file:Documentation/modules.txt>.
   The module will be called i2c-elektor.o.
 
+CONFIG_ITE_I2C_ALGO
+  This supports the use the ITE8172 I2C interface found on some MIPS
+  systems. Say Y if you have one of these. You should also say Y for
+  the ITE I2C peripheral driver support below.
+
+  This support is also available as a module. If you want to compile
+  it as a modules, say M here and read
+  <file:Documentation/modules.txt>.
+  The module will be called i2c-algo-ite.o.
+
+CONFIG_ITE_I2C_ADAP
+  This supports the ITE8172 I2C peripheral found on some MIPS
+  systems. Say Y if you have one of these. You should also say Y for
+  the ITE I2C driver algorithm support above.
+
+  This support is also available as a module. If you want to compile
+  it as a module, say M here and read
+  <file:Documentation/modules.txt>.
+  The module will be called i2c-adap-ite.o.
+
 CONFIG_I2C_CHARDEV
   Say Y here to use i2c-* device files, usually found in the /dev
   directory on your system.  They make it possible to have user-space



