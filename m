Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbTJAQW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTJAQVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:21:51 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:45462 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262241AbTJAQUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:20:41 -0400
Subject: [PATCH] [TRIVIAL 8/12] 2.6.0-test6-bk remove reference to
	modules.txt in net/irda/irnet/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065025174.1995.2417.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:19:35 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

Steven

--- 2.6-bk-current/net/irda/irnet/Kconfig	2003-09-30 21:09:21.000000000 -0600
+++ linux/net/irda/irnet/Kconfig	2003-09-30 22:14:29.000000000 -0600
@@ -2,11 +2,13 @@
 	tristate "IrNET protocol"
 	depends on IRDA && PPP
 	help
-	  Say Y here if you want to build support for the IrNET protocol.  If
-	  you want to compile it as a module (irnet), say M here and read
-	  <file:Documentation/modules.txt>.  IrNET is a PPP driver, so you
-	  will also need a working PPP subsystem (driver, daemon and
-	  config)...
+	  Say Y here if you want to build support for the IrNET protocol.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called irnet.
+
+	  IrNET is a PPP driver, so you will also need a working PPP
+	  subsystem (driver, daemon and config).
 
 	  IrNET is an alternate way to tranfer TCP/IP traffic over IrDA.  It
 	  uses synchronous PPP over a set of point to point IrDA sockets.  You







