Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWGLQkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWGLQkZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWGLQkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:40:25 -0400
Received: from [198.99.130.12] ([198.99.130.12]:8087 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751308AbWGLQkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:40:00 -0400
Message-Id: <200607121640.k6CGe6nP021236@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/5] UML - Reenable SysRq support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jul 2006 12:40:06 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sysrq works fine on UML.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/lib/Kconfig.debug
===================================================================
--- linux-2.6.17.orig/lib/Kconfig.debug	2006-07-12 11:26:41.000000000 -0400
+++ linux-2.6.17/lib/Kconfig.debug	2006-07-12 11:33:02.000000000 -0400
@@ -18,7 +18,6 @@ config ENABLE_MUST_CHECK
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
-	depends on !UML
 	help
 	  If you say Y here, you will have some control over the system even
 	  if the system crashes for example during kernel debugging (e.g., you

