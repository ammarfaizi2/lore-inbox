Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWF3Lf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWF3Lf5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWF3LdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:33:01 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15880 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751103AbWF3Lcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:32:52 -0400
Date: Fri, 30 Jun 2006 13:32:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/util.c: EXPORT_UNUSED_SYMBOL
Message-ID: <20060630113251.GR19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks an unused export as EXPORT_UNUSED_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm4-full/mm/util.c.old	2006-06-30 02:56:44.000000000 +0200
+++ linux-2.6.17-mm4-full/mm/util.c	2006-06-30 02:57:04.000000000 +0200
@@ -73,4 +73,4 @@
 
 	return p;
 }
-EXPORT_SYMBOL(strndup_user);
+EXPORT_UNUSED_SYMBOL(strndup_user);  /*  June 2006  */

