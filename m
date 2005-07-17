Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVGQPBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVGQPBh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 11:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVGQO7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 10:59:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23564 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261303AbVGQO5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 10:57:52 -0400
Date: Sun, 17 Jul 2005 16:57:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386: add missing Kconfig help text
Message-ID: <20050717145749.GN3613@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no help text for CONFIG_DEBUG_STACKOVERFLOW - add one.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Jesper Juhl on:
- 22 Dec 2004

--- linux-2.6.10-rc3-bk15-orig/arch/i386/Kconfig.debug	2004-12-06 22:24:16.000000000 +0100
+++ linux-2.6.10-rc3-bk15/arch/i386/Kconfig.debug	2004-12-22 23:25:38.000000000 +0100
@@ -18,6 +18,9 @@
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
+	help
+	  This option will cause messages to be printed if free stack space
+	  drops below a certain limit.
 
 config KPROBES
 	bool "Kprobes"


