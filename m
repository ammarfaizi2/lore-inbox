Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVCYBS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVCYBS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVCYBOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:14:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33297 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261375AbVCYBLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:11:18 -0500
Date: Fri, 25 Mar 2005 02:11:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/swap.c: unexport vm_acct_memory
Message-ID: <20050325011116.GV3966@stusta.de>
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
- 6 Mar 2005

--- linux-2.6.11-mm1-full/mm/swap.c.old	2005-03-04 16:05:42.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/swap.c	2005-03-04 16:05:57.000000000 +0100
@@ -412,7 +412,6 @@
 	}
 	preempt_enable();
 }
-EXPORT_SYMBOL(vm_acct_memory);
 
 #ifdef CONFIG_HOTPLUG_CPU
 static void lru_drain_cache(unsigned int cpu)

