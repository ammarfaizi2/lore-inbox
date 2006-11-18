Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755350AbWKRWzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbWKRWzr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 17:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755342AbWKRWza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 17:55:30 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:13488 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1755346AbWKRWz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 17:55:26 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/4] swsusp: Fix coding style in suspend.c
Date: Sat, 18 Nov 2006 23:48:35 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200611182335.27453.rjw@sisk.pl>
In-Reply-To: <200611182335.27453.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611182348.36243.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style in suspend.c.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/snapshot.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.19-rc5-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/power/snapshot.c
+++ linux-2.6.19-rc5-mm2/kernel/power/snapshot.c
@@ -85,7 +85,8 @@ unsigned long get_safe_page(gfp_t gfp_ma
 	return (unsigned long)get_image_page(gfp_mask, PG_SAFE);
 }
 
-static struct page *alloc_image_page(gfp_t gfp_mask) {
+static struct page *alloc_image_page(gfp_t gfp_mask)
+{
 	struct page *page;
 
 	page = alloc_page(gfp_mask);
