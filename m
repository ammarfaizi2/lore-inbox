Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVCFOxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVCFOxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 09:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVCFOuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 09:50:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32528 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261420AbVCFOug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 09:50:36 -0500
Date: Sun, 6 Mar 2005 15:50:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/swap.c: unexport vm_acct_memory
Message-ID: <20050306145032.GL5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm1-full/mm/swap.c.old	2005-03-04 16:05:42.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/swap.c	2005-03-04 16:05:57.000000000 +0100
@@ -412,7 +412,6 @@
 	}
 	preempt_enable();
 }
-EXPORT_SYMBOL(vm_acct_memory);
 
 #ifdef CONFIG_HOTPLUG_CPU
 static void lru_drain_cache(unsigned int cpu)

