Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTDWQac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTDWQac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:30:32 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:15 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S264113AbTDWQaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:30:30 -0400
Date: Wed, 23 Apr 2003 10:21:14 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/block/genhd.c
Message-ID: <20030423152114.GC5681@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a patch that switches the file to use C99 initializers. The patch
is against the current BK.

Art Haas

===== drivers/block/genhd.c 1.81 vs edited =====
--- 1.81/drivers/block/genhd.c	Sun Apr 20 01:22:58 2003
+++ edited/drivers/block/genhd.c	Wed Apr 23 10:13:03 2003
@@ -623,10 +623,10 @@
 }
 
 struct seq_operations diskstats_op = {
-	start:	diskstats_start,
-	next:	diskstats_next,
-	stop:	diskstats_stop,
-	show:	diskstats_show
+	.start	= diskstats_start,
+	.next	= diskstats_next,
+	.stop	= diskstats_stop,
+	.show	= diskstats_show
 };
 
 
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
