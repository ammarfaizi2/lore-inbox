Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWINSaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWINSaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWINSaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:30:09 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:51928 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750987AbWINSaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:30:07 -0400
Subject: [PATCH] RCU: CREDITS and MAINTAINERS
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Paul McKenney <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 11:30:28 -0700
Message-Id: <1158258628.5414.4.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Read-Copy Update (RCU), listing Dipankar Sarma as
maintainer, and giving the URL for Paul McKenney's RCU site.  Add MAINTAINERS
entry for rcutorture, listing myself as maintainer.  Add CREDITS entries for
developers of RCU, RCU variants, and rcutorture.  Use Paul McKenney's
preferred email address in include/linux/rcupdate.h .

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 CREDITS                  |   16 ++++++++++++++++
 MAINTAINERS              |   13 +++++++++++++
 include/linux/rcupdate.h |    2 +-
 3 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/CREDITS b/CREDITS
index 0fe904e..61b4bb5 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2227,6 +2227,12 @@ D: tc: HFSC scheduler
 S: Freiburg
 S: Germany
 
+N: Paul E. McKenney
+E: paulmck@us.ibm.com
+W: http://www.rdrop.com/users/paulmck/
+D: RCU and variants
+D: rcutorture module
+
 N: Mike McLagan
 E: mike.mclagan@linux.org
 W: http://www.invlogic.com/~mmclagan
@@ -2960,6 +2966,10 @@ S: 69 rue Dunois
 S: 75013 Paris
 S: France
 
+N: Dipankar Sarma
+E: dipankar@in.ibm.com
+D: RCU
+
 N: Hannu Savolainen
 E: hannu@opensound.com
 D: Maintainer of the sound drivers until 2.1.x days.
@@ -3272,6 +3282,12 @@ S: 3 Ballow Crescent
 S: MacGregor A.C.T 2615
 S: Australia
 
+N: Josh Triplett
+E: josh@freedesktop.org
+P: 1024D/D0FE7AFB B24A 65C9 1D71 2AC2 DE87  CA26 189B 9946 D0FE 7AFB
+D: rcutorture maintainer
+D: lock annotations, finding and fixing lock bugs
+
 N: Winfried Trmper
 E: winni@xpilot.org
 W: http://www.shop.de/~winni/
diff --git a/MAINTAINERS b/MAINTAINERS
index 25cd707..fa8fc95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2402,6 +2402,19 @@ M:	mporter@kernel.crashing.org
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+READ-COPY UPDATE (RCU)
+P:	Dipankar Sarma
+M:	dipankar@in.ibm.com
+W:	http://www.rdrop.com/users/paulmck/rclock/
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+
+RCUTORTURE MODULE
+P:	Josh Triplett
+M:	josh@freedesktop.org
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 REAL TIME CLOCK DRIVER
 P:	Paul Gortmaker
 M:	p_gortmaker@yahoo.com
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b4ca73d..20243ee 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -19,7 +19,7 @@
  *
  * Author: Dipankar Sarma <dipankar@in.ibm.com>
  * 
- * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
+ * Based on the original work by Paul McKenney <paulmck@us.ibm.com>
  * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
  * Papers:
  * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
-- 
1.4.1.1


