Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVEMBSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVEMBSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 21:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVEMBRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 21:17:39 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57867 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262220AbVEMBLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 21:11:22 -0400
Date: Fri, 13 May 2005 03:11:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/sequencer_syms: unexport reprogram_timer
Message-ID: <20050513011116.GB3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remoes an unneeded EXPORT_SYMBOL.

--- linux-2.6.12-rc4-mm1-full/sound/oss/sequencer_syms.c.old	2005-05-13 02:50:55.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/sound/oss/sequencer_syms.c	2005-05-13 02:51:01.000000000 +0200
@@ -19,7 +19,6 @@
 EXPORT_SYMBOL(sound_timer_init);
 EXPORT_SYMBOL(sound_timer_interrupt);
 EXPORT_SYMBOL(sound_timer_syncinterval);
-EXPORT_SYMBOL(reprogram_timer);
 
 /* Tuning */
 

