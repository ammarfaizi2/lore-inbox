Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVCCWCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVCCWCP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVCCV7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:59:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10506 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262632AbVCCVus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:50:48 -0500
Date: Thu, 3 Mar 2005 22:50:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport console_unblank
Message-ID: <20050303215041.GR4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage of console_unblank in the 
kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc5-mm1-full/kernel/printk.c.old	2005-03-03 17:04:18.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/printk.c	2005-03-03 17:04:24.000000000 +0100
@@ -757,7 +757,6 @@
 			c->unblank();
 	release_console_sem();
 }
-EXPORT_SYMBOL(console_unblank);
 
 /*
  * Return the console tty driver structure and its associated index

