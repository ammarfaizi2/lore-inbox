Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWJAQFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWJAQFm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWJAQFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:05:42 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:21534 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1751195AbWJAQFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:05:41 -0400
Message-Id: <20061001160130.326875000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sun, 01 Oct 2006 09:01:30 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org
Cc: jengelh@gmx.de
Subject: [PATCH] docs: small kbuild cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reading this I noticed that the contents of this document
list section "3.8 Command line dependency" but it doesn't exist 
in the document.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 Documentation/kbuild/kconfig-language.txt |    2 +-
 Documentation/kbuild/makefiles.txt        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18/Documentation/kbuild/kconfig-language.txt
===================================================================
--- linux-2.6.18.orig/Documentation/kbuild/kconfig-language.txt
+++ linux-2.6.18/Documentation/kbuild/kconfig-language.txt
@@ -1,7 +1,7 @@
 Introduction
 ------------
 
-The configuration database is collection of configuration options
+The configuration database is a collection of configuration options
 organized in a tree structure:
 
 	+- Code maturity level options
Index: linux-2.6.18/Documentation/kbuild/makefiles.txt
===================================================================
--- linux-2.6.18.orig/Documentation/kbuild/makefiles.txt
+++ linux-2.6.18/Documentation/kbuild/makefiles.txt
@@ -390,7 +390,7 @@ more details, with real examples.
 	The kernel may be built with several different versions of
 	$(CC), each supporting a unique set of features and options.
 	kbuild provide basic support to check for valid options for $(CC).
-	$(CC) is useally the gcc compiler, but other alternatives are
+	$(CC) is usually the gcc compiler, but other alternatives are
 	available.
 
     as-option
--
