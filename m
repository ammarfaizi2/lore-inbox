Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVAaRm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVAaRm4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVAaRka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:40:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5900 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261276AbVAaRjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:39:52 -0500
Date: Mon, 31 Jan 2005 18:39:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/sysrq.c: remove the unused sysrq_power_off
Message-ID: <20050131173950.GV18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysrq_power_off was completely unused.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

