Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbULLTjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbULLTjf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 14:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbULLTjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:39:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23825 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262089AbULLTjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:39:32 -0500
Date: Sun, 12 Dec 2004 20:39:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Mosberger-Tang <davidm@hpl.hp.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ia64 smpboot.c: remove an unused function
Message-ID: <20041212193921.GA22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes an unused global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/ia64/kernel/smpboot.c.old	2004-12-12 02:51:04.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/ia64/kernel/smpboot.c	2004-12-12 02:51:18.000000000 +0100
@@ -356,11 +356,6 @@
 	return cpu_idle();
 }
 
-struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
-{
-	return NULL;
-}
-
 struct create_idle {
 	struct task_struct *idle;
 	struct completion done;

