Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVDOPVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVDOPVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 11:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVDOPVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 11:21:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34322 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261840AbVDOPKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 11:10:49 -0400
Date: Fri, 15 Apr 2005 17:10:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport panic_timeout
Message-ID: <20050415151048.GL5456@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Mar 2005

--- linux-2.6.11-rc5-mm1-full/kernel/panic.c.old	2005-03-04 00:54:46.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/panic.c	2005-03-04 00:54:54.000000000 +0100
@@ -24,8 +24,6 @@
 int panic_on_oops;
 int tainted;
 
-EXPORT_SYMBOL(panic_timeout);
-
 struct notifier_block *panic_notifier_list;
 
 EXPORT_SYMBOL(panic_notifier_list);

