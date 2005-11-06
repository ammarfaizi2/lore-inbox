Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVKFAz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVKFAz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVKFAz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:55:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15885 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932262AbVKFAzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:55:55 -0500
Date: Sun, 6 Nov 2005 01:55:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/slab.c: fix a comment typo
Message-ID: <20051106005553.GH3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.14-rc5-mm1-full/mm/slab.c.old	2005-11-06 01:10:59.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/mm/slab.c	2005-11-06 01:11:06.000000000 +0100
@@ -434,7 +434,7 @@
 /* Optimization question: fewer reaps means less 
  * probability for unnessary cpucache drain/refill cycles.
  *
- * OTHO the cpuarrays can contain lots of objects,
+ * OTOH the cpuarrays can contain lots of objects,
  * which could lock up otherwise freeable slabs.
  */
 #define REAPTIMEOUT_CPUC	(2*HZ)
