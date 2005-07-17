Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVGQOix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVGQOix (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 10:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVGQOix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 10:38:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8460 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261303AbVGQOiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 10:38:50 -0400
Date: Sun, 17 Jul 2005 16:38:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] m32r: add missing Kconfig help text
Message-ID: <20050717143847.GG3613@stusta.de>
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

--- linux-2.6.10-rc3-bk15-orig/arch/m32r/Kconfig.debug	2004-12-06 22:24:16.000000000 +0100
+++ linux-2.6.10-rc3-bk15/arch/m32r/Kconfig.debug	2004-12-22 23:28:32.000000000 +0100
@@ -5,6 +5,9 @@
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
+	help
+	  This option will cause messages to be printed if free stack space
+	  drops below a certain limit.
 
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"


