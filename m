Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291965AbSBNXE1>; Thu, 14 Feb 2002 18:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291966AbSBNXEQ>; Thu, 14 Feb 2002 18:04:16 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:7347 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S291965AbSBNXEG>; Thu, 14 Feb 2002 18:04:06 -0500
Message-Id: <200202142216.PAA05141@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: "Simon G. Vogl" <simon@tk.uni-linz.ac.at>
Subject: [PATCH] 2.5.5-pre1 add two help texts in drivers/i2c/Config.help
Date: Thu, 14 Feb 2002 16:02:42 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two help texts for CONFIG_ITE_I2C_ALGO and
CONFIG_ITE_I2C_ADAP in drivers/i2c/Config.help. 

Steven

--- linux-2.5.5-pre1/drivers/i2c/Config.help.orig       Thu Feb 14 15:39:24 2002
+++ linux-2.5.5-pre1/drivers/i2c/Config.help    Thu Feb 14 15:47:05 2002
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

