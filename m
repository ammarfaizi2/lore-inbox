Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTJAQOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTJAQOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:14:19 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:59794 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262193AbTJAQOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:14:17 -0400
Subject: [PATCH] [TRIVIAL 1/12] 2.6.0-test6-bk remove reference to
	modules.txt in drivers/atm/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065024797.1995.2335.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:13:17 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

Steven

--- 2.6-bk-current/drivers/atm/Kconfig	2003-09-30 21:07:23.000000000 -0600
+++ linux/drivers/atm/Kconfig	2003-09-30 21:33:16.000000000 -0600
@@ -32,9 +32,8 @@
 	  The driver works with MMF (-MF or ...F) and UTP-5 (-U5 or ...D)
 	  adapters.
 
-	  This driver is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.  The module will be called eni.
+	  To compile this driver as a module, choose M here: the
+	  module will be called eni.
 
 config ATM_ENI_DEBUG
 	bool "Enable extended debugging"
@@ -138,10 +137,8 @@
 	  Driver for the Fujitsu FireStream 155 (MB86697) and
 	  FireStream 50 (MB86695) ATM PCI chips.
 
-	  This driver is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.  The module will be called
-	  firestream.
+	  To compile this driver as a module, choose M here: the
+	  module will be called firestream.
 
 config ATM_ZATM
 	tristate "ZeitNet ZN1221/ZN1225"
@@ -150,9 +147,8 @@
 	  Driver for the ZeitNet ZN1221 (MMF) and ZN1225 (UTP-5) 155 Mbps ATM
 	  adapters.
 
-	  This driver is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.  The module will be called zatm.
+	  To compile this driver as a module, choose M here: the
+	  module will be called zatm.
 
 config ATM_ZATM_DEBUG
 	bool "Enable extended debugging"
@@ -176,10 +172,8 @@
 	  25 and for 155 Mbps, including IDT cards and the Fore ForeRunnerLE
 	  series. Say Y if you have one of those.
 
-	  This driver is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>. The module will be called
-	  nicstar.
+	  To compile this driver as a module, choose M here: the
+	  module will be called nicstar.
 
 config ATM_NICSTAR_USE_SUNI
 	bool "Use suni PHY driver (155Mbps)"
@@ -209,9 +203,8 @@
 	help
 	  Driver for the IDT 77252 ATM PCI chips.
 
-	  This driver is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>. The module will be called idt77252
+	  To compile this driver as a module, choose M here: the
+	  module will be called idt77252.
 
 config ATM_IDT77252_DEBUG
 	bool "Enable debugging messages"







