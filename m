Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVAMGiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVAMGiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVAMGiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:38:23 -0500
Received: from waste.org ([216.27.176.166]:49026 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261169AbVAMGiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:38:10 -0500
Date: Wed, 12 Jan 2005 22:38:03 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] random whitespace doh
Message-ID: <20050113063803.GW2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone actually spotted this already.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 09:49:48.299725239 -0800
+++ rnd/drivers/char/random.c	2005-01-12 09:50:47.005240922 -0800
@@ -2368,7 +2368,7 @@
 	cookie -= tmp[17] + sseq;
 	/* Cookie is now reduced to (count * 2^24) ^ (hash % 2^24) */
 
-	diff = (count - (cookie >> COOKIEBITS)) & ((__u32) - 1 >> COOKIEBITS);
+	diff = (count - (cookie >> COOKIEBITS)) & ((__u32)-1 >> COOKIEBITS);
 	if (diff >= maxdiff)
 		return (__u32)-1;
 

-- 
Mathematics is the supreme nostalgia of our time.
