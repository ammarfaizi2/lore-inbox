Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbTJAQZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTJAQVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:21:24 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:59797 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262407AbTJAQT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:19:29 -0400
Subject: [PATCH] [TRIVIAL 4/12] 2.6.0-test6-bk remove reference to
	modules.txt in drivers/net/wan/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065025105.1995.2396.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:18:25 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

Steven

--- 2.6-bk-current/drivers/net/wan/Kconfig	2003-09-30 21:05:41.000000000 -0600
+++ linux/drivers/net/wan/Kconfig	2003-09-30 21:55:21.000000000 -0600
@@ -332,10 +332,8 @@
 	  This driver is for wanXL PCI cards made by SBE Inc.  If you have
 	  such a card, say Y here and see <http://hq.pm.waw.pl/pub/hdlc/>.
 
-	  If you want to compile the driver as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called wanxl.
+	  To compile this as a module, choose M here: the module will be
+	  called wanxl.
 
 	  If unsure, say N here.
 







