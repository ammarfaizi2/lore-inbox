Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVBXXty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVBXXty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVBXXkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:40:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54537 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262533AbVBXXhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:37:00 -0500
Date: Fri, 25 Feb 2005 00:36:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/proc/kcore.c: make a function static
Message-ID: <20050224233657.GN8651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 8 Jan 2005

--- linux-2.6.10-mm2-full/fs/proc/kcore.c.old	2005-01-08 17:13:25.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/proc/kcore.c	2005-01-08 17:13:37.000000000 +0100
@@ -97,7 +97,7 @@
 /*
  * determine size of ELF note
  */
-int notesize(struct memelfnote *en)
+static int notesize(struct memelfnote *en)
 {
 	int sz;
 

