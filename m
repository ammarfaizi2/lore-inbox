Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVAYHv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVAYHv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVAYHvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:51:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19207 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261850AbVAYHtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:49:13 -0500
Date: Tue, 25 Jan 2005 08:49:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/resource.c: make resource_op static
Message-ID: <20050125074910.GF3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes resource_op static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/kernel/resource.c.old	2004-12-12 03:15:10.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/resource.c	2004-12-12 03:15:20.000000000 +0100
@@ -91,7 +91,7 @@
 	return 0;
 }
 
-struct seq_operations resource_op = {
+static struct seq_operations resource_op = {
 	.start	= r_start,
 	.next	= r_next,
 	.stop	= r_stop,

