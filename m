Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbTJAQVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTJAQVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:21:09 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:5014 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262418AbTJAQTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:19:48 -0400
Subject: [PATCH] [TRIVIAL 5/12] 2.6.0-test6-bk remove reference to
	modules.txt in drivers/usb/input/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065025124.1995.2406.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:18:44 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

Steven

--- 2.6-bk-current/drivers/usb/input/Kconfig	2003-09-30 21:10:32.000000000 -0600
+++ linux/drivers/usb/input/Kconfig	2003-09-30 22:00:19.000000000 -0600
@@ -186,8 +186,5 @@
 	  For information about how to connect the X-Box pad to USB, see
 	  Documentation/input/xpad.txt.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called xpad.  If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
-
+	  To compile this driver as a module, choose M here: the
+	  module will be called xpad.







