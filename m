Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVBYAEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVBYAEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVBXX56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:57:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6922 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262563AbVBXXkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:40:31 -0500
Date: Fri, 25 Feb 2005 00:40:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/sysrq.c: remove the unused sysrq_power_off
Message-ID: <20050224234023.GA8651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysrq_power_off was completely unused.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 31 Jan 2005

--- linux-2.6.11-rc2-mm2-full/drivers/char/sysrq.c.old	2005-01-31 15:42:32.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/sysrq.c	2005-01-31 15:42:55.000000000 +0100
@@ -59,9 +59,6 @@
 /* Whether we react on sysrq keys or just ignore them */
 int sysrq_enabled = 1;
 
-/* Machine specific power off function */
-void (*sysrq_power_off)(void);
-
 /* Loglevel sysrq handler */
 static void sysrq_handle_loglevel(int key, struct pt_regs *pt_regs,
 				  struct tty_struct *tty) 

