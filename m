Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTJAQgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTJAQeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:34:01 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:58006 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262352AbTJAQUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:20:50 -0400
Subject: [PATCH] [TRIVIAL 9/12] 2.6.0-test6-bk remove reference to
	modules.txt in net/sctp/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065025185.1995.2419.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:19:46 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

Steven

--- 2.6-bk-current/net/sctp/Kconfig	2003-09-30 21:05:21.000000000 -0600
+++ linux/net/sctp/Kconfig	2003-09-30 22:19:38.000000000 -0600
@@ -32,10 +32,8 @@
 	  -- network-level fault tolerance through supporting of multi-
 	  homing at either or both ends of an association."
 
-	  This protocol support is also available as a module ( = code which
-	  can be inserted in and removed from the running kernel whenever you
-	  want). The module will be called sctp. If you want to compile it
-	  as a module, say M here and read <file:Documentation/modules.txt>.
+	  To compile this as a module, choose M here: the
+	  module will be called sctp.
 
 	  If in doubt, say N.
 







