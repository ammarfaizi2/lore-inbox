Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVFMTmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVFMTmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVFMTmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:42:04 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:12717 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261249AbVFMTlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:41:06 -0400
Date: Mon, 13 Jun 2005 12:34:41 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: geert@linux-m68k.org, akpm <akpm@osdl.org>
Subject: [PATCH] macmodes: needs a license
Message-Id: <20050613123441.56721c61.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Randy Dunlap <rdunlap@xenotime.net>

Module needs a license to prevent kernel tainting.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

diffstat:=
 drivers/video/macmodes.c |    1 +
 1 files changed, 1 insertion(+)

diff -Naurp ./drivers/video/macmodes.c~taint_video ./drivers/video/macmodes.c
--- ./drivers/video/macmodes.c~taint_video	2005-06-10 18:41:17.000000000 -0700
+++ ./drivers/video/macmodes.c	2005-06-13 10:30:59.000000000 -0700
@@ -387,3 +387,4 @@ int __init mac_find_mode(struct fb_var_s
 }
 EXPORT_SYMBOL(mac_find_mode);
 
+MODULE_LICENSE("GPL");


---
