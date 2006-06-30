Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWF3Lbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWF3Lbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWF3Lbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:31:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11528 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750904AbWF3Lbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:31:43 -0400
Date: Fri, 30 Jun 2006 13:31:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/sysctl.c: EXPORT_UNUSED_SYMBOL
Message-ID: <20060630113141.GK19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks an unsed export as EXPORT_UNUSED_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm4-full/kernel/sysctl.c.old	2006-06-30 02:34:13.000000000 +0200
+++ linux-2.6.17-mm4-full/kernel/sysctl.c	2006-06-30 02:34:39.000000000 +0200
@@ -2746,7 +2746,7 @@
 EXPORT_SYMBOL(proc_dointvec);
 EXPORT_SYMBOL(proc_dointvec_jiffies);
 EXPORT_SYMBOL(proc_dointvec_minmax);
-EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
+EXPORT_UNUSED_SYMBOL(proc_dointvec_userhz_jiffies);  /*  June 2006  */
 EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
 EXPORT_SYMBOL(proc_dostring);
 EXPORT_SYMBOL(proc_doulongvec_minmax);

