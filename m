Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbTJAQUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTJAQUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:20:45 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:26774 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262424AbTJAQUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:20:18 -0400
Subject: [PATCH] [TRIVIAL 7/12] 2.6.0-test6-bk remove reference to
	modules.txt in net/irda/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065025155.1995.2410.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:19:15 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

Steven

--- 2.6-bk-current/net/irda/Kconfig	2003-09-30 21:08:13.000000000 -0600
+++ linux/net/irda/Kconfig	2003-09-30 22:09:04.000000000 -0600
@@ -22,9 +22,8 @@
 	  will need to install some OBEX application, such as OpenObex :
 	  <http://sourceforge.net/projects/openobex/>
 
-	  This support is also available as a module called irda.  If you
-	  want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+	  To compile this driver as a module, choose M here: the
+	  module will be called irda.
 
 comment "IrDA protocols"
 	depends on IRDA







