Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbTJAQdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTJAQU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:20:57 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:15510 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262422AbTJAQUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:20:08 -0400
Subject: [PATCH] [TRIVIAL 6/12] 2.6.0-test6-bk remove reference to
	modules.txt in net/irda/ircomm/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065025144.1995.2408.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:19:05 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

Steven

--- 2.6-bk-current/net/irda/ircomm/Kconfig	2003-09-30 21:03:39.000000000 -0600
+++ linux/net/irda/ircomm/Kconfig	2003-09-30 22:06:03.000000000 -0600
@@ -2,12 +2,13 @@
 	tristate "IrCOMM protocol"
 	depends on IRDA
 	help
-	  Say Y here if you want to build support for the IrCOMM protocol.  If
-	  you want to compile it as a module (you will get ircomm and
-	  ircomm-tty), say M here and read <file:Documentation/modules.txt>.
+	  Say Y here if you want to build support for the IrCOMM protocol.
+
+	  To compile this driver as a module, choose M here: the
+	  modules will be called ircomm and ircomm-tty.
+
 	  IrCOMM implements serial port emulation, and makes it possible to
-	  use all existing applications that understands TTY's with an
-	  infrared link.  Thus you should be able to use application like PPP,
-	  minicom and others.  Enabling this option will create two modules
-	  called ircomm and ircomm_tty.
+	  use all existing applications that understand TTY's with an
+	  infrared link.  Thus you should be able to use applications like PPP,
+	  minicom and others.
 







