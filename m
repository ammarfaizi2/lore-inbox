Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVAaHtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVAaHtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVAaHpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:45:51 -0500
Received: from waste.org ([216.27.176.166]:45549 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261970AbVAaHoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:44:02 -0500
Date: Sun, 30 Jan 2005 23:44:00 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/8] lib/sort: turn off self-test
Message-ID: <20050131074400.GL2891@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doh.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm2/lib/sort.c
===================================================================
--- mm2.orig/lib/sort.c	2005-01-30 22:37:28.000000000 -0800
+++ mm2/lib/sort.c	2005-01-30 23:41:40.000000000 -0800
@@ -82,7 +82,7 @@
 
 MODULE_LICENSE("GPL");
 
-#if 1
+#if 0
 /* a simple boot-time regression test */
 
 int cmpint(const void *a, const void *b)


-- 
Mathematics is the supreme nostalgia of our time.
