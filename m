Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWDRPGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWDRPGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWDRPGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:06:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49413 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932257AbWDRPGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:06:04 -0400
Date: Tue, 18 Apr 2006 17:06:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/sysctl.c: unexport proc_dointvec_userhz_jiffies
Message-ID: <20060418150602.GE11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unused EXPORT_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 11 Apr 2006

--- linux-2.6.17-rc1-mm2-full/kernel/sysctl.c.old	2006-04-11 01:25:38.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/kernel/sysctl.c	2006-04-11 01:26:01.000000000 +0200
@@ -2532,7 +2532,6 @@
 EXPORT_SYMBOL(proc_dointvec);
 EXPORT_SYMBOL(proc_dointvec_jiffies);
 EXPORT_SYMBOL(proc_dointvec_minmax);
-EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
 EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
 EXPORT_SYMBOL(proc_dostring);
 EXPORT_SYMBOL(proc_doulongvec_minmax);

