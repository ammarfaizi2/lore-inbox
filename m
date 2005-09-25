Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbVIYPGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbVIYPGc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbVIYPGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:06:32 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:47883 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751509AbVIYPGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:06:31 -0400
Date: Sun, 25 Sep 2005 17:06:25 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Typo fix: explictly -> explicitly
Message-Id: <20050925170625.1e22e79b.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, Andrew,

Typo fix: explictly -> explicitly.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/cpusets.txt |    2 +-
 drivers/char/cyclades.c   |    2 +-
 drivers/scsi/mesh.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.14-rc2.orig/Documentation/cpusets.txt	2005-09-13 21:20:57.000000000 +0200
+++ linux-2.6.14-rc2/Documentation/cpusets.txt	2005-09-25 17:02:19.000000000 +0200
@@ -94,7 +94,7 @@
 But larger systems, which benefit more from careful processor and
 memory placement to reduce memory access times and contention,
 and which typically represent a larger investment for the customer,
-can benefit from explictly placing jobs on properly sized subsets of
+can benefit from explicitly placing jobs on properly sized subsets of
 the system.
 
 This can be especially valuable on:
--- linux-2.6.14-rc2.orig/drivers/char/cyclades.c	2005-09-13 21:21:05.000000000 +0200
+++ linux-2.6.14-rc2/drivers/char/cyclades.c	2005-09-25 17:02:28.000000000 +0200
@@ -281,7 +281,7 @@
  * make sure "cyc" appears in all kernel messages; all soft interrupts
  * handled by same routine; recognize out-of-band reception; comment
  * out some diagnostic messages; leave RTS/CTS flow control to hardware;
- * fix race condition in -Z buffer management; only -Y needs to explictly
+ * fix race condition in -Z buffer management; only -Y needs to explicitly
  * flush chars; tidy up some startup messages;
  *
  * Revision 1.36.4.18  1996/07/25 18:57:31  bentson
--- linux-2.6.14-rc2.orig/drivers/scsi/mesh.c	2005-09-13 21:21:12.000000000 +0200
+++ linux-2.6.14-rc2/drivers/scsi/mesh.c	2005-09-25 17:02:25.000000000 +0200
@@ -730,7 +730,7 @@
 		 * issue a SEQ_MSGOUT to get the mesh to drop ACK.
 		 */
 		if ((in_8(&mr->bus_status0) & BS0_ATN) == 0) {
-			dlog(ms, "bus0 was %.2x explictly asserting ATN", mr->bus_status0);
+			dlog(ms, "bus0 was %.2x explicitly asserting ATN", mr->bus_status0);
 			out_8(&mr->bus_status0, BS0_ATN); /* explicit ATN */
 			mesh_flush_io(mr);
 			udelay(1);


-- 
Jean Delvare
