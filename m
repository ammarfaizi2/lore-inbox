Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTJAQW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJAQVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:21:55 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:8599 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262438AbTJAQVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:21:06 -0400
Subject: [PATCH] [TRIVIAL 10/12] 2.6.0-test6-bk remove reference to
	modules.txt in net/bridge/netfilter/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: bdschuym@pandora.be
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065025199.1995.2421.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:19:59 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

This was done slightly differently, maintaining the existing style
in this file.  The other tristate options do not specify the module name.

Steven

--- 2.6-bk-current/net/bridge/netfilter/Kconfig	2003-09-30 21:05:44.000000000 -0600
+++ linux/net/bridge/netfilter/Kconfig	2003-09-30 22:23:27.000000000 -0600
@@ -81,8 +81,7 @@
 	  the rate at which a rule can be matched. This match is the
 	  equivalent of the iptables limit match.
 
-	  If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.  If unsure, say `N'.
+	  To compile it as a module, choose M here.  If unsure, say N.
 
 config BRIDGE_EBT_MARK
 	tristate "ebt: mark filter support"







