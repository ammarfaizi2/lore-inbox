Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161197AbWASNsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbWASNsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 08:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbWASNsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 08:48:51 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:53404 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1161197AbWASNsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 08:48:51 -0500
Date: Thu, 19 Jan 2006 13:47:28 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Extra brace in mm/mempolicy.c on 2.6.16-rc1-mm1
Message-ID: <Pine.LNX.4.58.0601191344530.29067@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An additional brace in mm/mempolicy.c causes a compile problem


--- linux-2.6.16-rc1-mm1-clean/mm/mempolicy.c	2006-01-19 11:21:59.000000000 +0000
+++ linux-2.6.16-rc1-mm1-mempolicy/mm/mempolicy.c	2006-01-19 12:47:10.000000000 +0000
@@ -543,7 +543,6 @@
 	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(page) ==1)
 		if (isolate_lru_page(page))
 			list_add(&page->lru, pagelist);
-	}
 }

 /*
