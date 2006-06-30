Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751741AbWF3Lem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbWF3Lem (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWF3LdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:33:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15368 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750811AbWF3Lct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:32:49 -0400
Date: Fri, 30 Jun 2006 13:32:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/mmzone.c: EXPORT_UNUSED_SYMBOL
Message-ID: <20060630113248.GQ19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks three unused exports as EXPORT_UNUSED_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 mm/mmzone.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.17-mm4-full/mm/mmzone.c.old	2006-06-30 02:54:10.000000000 +0200
+++ linux-2.6.17-mm4-full/mm/mmzone.c	2006-06-30 02:54:55.000000000 +0200
@@ -15,7 +15,7 @@
 	return NODE_DATA(first_online_node);
 }
 
-EXPORT_SYMBOL(first_online_pgdat);
+EXPORT_UNUSED_SYMBOL(first_online_pgdat);  /*  June 2006  */
 
 struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
 {
@@ -25,7 +25,7 @@
 		return NULL;
 	return NODE_DATA(nid);
 }
-EXPORT_SYMBOL(next_online_pgdat);
+EXPORT_UNUSED_SYMBOL(next_online_pgdat);  /*  June 2006  */
 
 
 /*
@@ -46,5 +46,5 @@
 	}
 	return zone;
 }
-EXPORT_SYMBOL(next_zone);
+EXPORT_UNUSED_SYMBOL(next_zone);  /*  June 2006  */
 

