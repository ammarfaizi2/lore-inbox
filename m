Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWF3Lel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWF3Lel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWF3Leg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:34:36 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19720 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751741AbWF3LeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:34:23 -0400
Date: Fri, 30 Jun 2006 13:34:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/softirq.c: EXPORT_UNUSED_SYMBOL
Message-ID: <20060630113421.GX19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks an unused export as EXPORT_UNUSED_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm4-full/kernel/softirq.c.old	2006-06-30 04:26:44.000000000 +0200
+++ linux-2.6.17-mm4-full/kernel/softirq.c	2006-06-30 04:27:03.000000000 +0200
@@ -311,7 +311,7 @@
 	softirq_vec[nr].action = action;
 }
 
-EXPORT_SYMBOL(open_softirq);
+EXPORT_UNUSED_SYMBOL(open_softirq);  /*  June 2006  */
 
 /* Tasklets */
 struct tasklet_head

