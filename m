Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWF3Ldq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWF3Ldq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWF3LdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:33:07 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14856 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750915AbWF3Lcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:32:41 -0400
Date: Fri, 30 Jun 2006 13:32:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/memory.c: EXPORT_UNUSED_SYMBOL
Message-ID: <20060630113240.GP19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks an unused export as EXPORT_UNUSED_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm4-full/mm/memory.c.old	2006-06-30 02:51:59.000000000 +0200
+++ linux-2.6.17-mm4-full/mm/memory.c	2006-06-30 02:52:26.000000000 +0200
@@ -1863,7 +1863,7 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(vmtruncate_range);
+EXPORT_UNUSED_SYMBOL(vmtruncate_range);  /*  June 2006  */
 
 /* 
  * Primitive swap readahead code. We simply read an aligned block of

