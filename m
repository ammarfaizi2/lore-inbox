Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVE3Aes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVE3Aes (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 20:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVE3Ac4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 20:32:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18960 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261484AbVE3A2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 20:28:42 -0400
Date: Mon, 30 May 2005 02:28:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/sequencer_syms: unexport reprogram_timer
Message-ID: <20050530002840.GN10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remoes an unneeded EXPORT_SYMBOL.

---

This patch was already sent on:
- 13 May 2005

--- linux-2.6.12-rc4-mm1-full/sound/oss/sequencer_syms.c.old	2005-05-13 02:50:55.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/sound/oss/sequencer_syms.c	2005-05-13 02:51:01.000000000 +0200
@@ -19,7 +19,6 @@
 EXPORT_SYMBOL(sound_timer_init);
 EXPORT_SYMBOL(sound_timer_interrupt);
 EXPORT_SYMBOL(sound_timer_syncinterval);
-EXPORT_SYMBOL(reprogram_timer);
 
 /* Tuning */
 

