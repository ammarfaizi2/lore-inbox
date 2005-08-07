Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752885AbVHGV6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbVHGV6G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887AbVHGV6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:58:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18951 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752885AbVHGV6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:58:06 -0400
Date: Sun, 7 Aug 2005 23:58:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: lethal@linux-sh.org, rc@rc0.org.uk,
       linuxsh-shmedia-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/sh64/Kconfig: doesn't need it's own LOG_BUF_SHIFT
Message-ID: <20050807215803.GA4006@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The LOG_BUF_SHIFT from lib/Kconfig.debug is sufficient.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 31 Jul 2005

--- linux-2.6.13-rc4-mm1/arch/sh64/Kconfig.old	2005-07-31 18:24:19.000000000 +0200
+++ linux-2.6.13-rc4-mm1/arch/sh64/Kconfig	2005-07-31 18:24:26.000000000 +0200
@@ -29,10 +29,6 @@
 	bool
 	default y
 
-config LOG_BUF_SHIFT
-	int
-	default 14
-
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 

