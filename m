Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbUKCPX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbUKCPX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUKCPX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:23:27 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:2974 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261650AbUKCPW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:22:57 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041103152253.24869.44212.45317@localhost.localdomain>
In-Reply-To: <20041103152246.24869.2759.68945@localhost.localdomain>
References: <20041103152246.24869.2759.68945@localhost.localdomain>
Subject: [PATCH 2/5] documentation: Remove drivers/char/README.cyclomY
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [68.238.31.6] at Wed, 3 Nov 2004 09:22:53 -0600
Date: Wed, 3 Nov 2004 09:22:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove obsolete file from drivers/char.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/drivers/char/README.cyclomY linux-2.6.9/drivers/char/README.cyclomY
--- linux-2.6.9-original/drivers/char/README.cyclomY	2004-10-18 17:53:46.000000000 -0400
+++ linux-2.6.9/drivers/char/README.cyclomY	1969-12-31 19:00:00.000000000 -0500
@@ -1,23 +0,0 @@
-
-NOTE: Earlier versions of the driver mapped ttyC0 to minor
-number 32, but this is changed in this distribution.  Port ttyC0
-now maps to minor number 0.)  The following patch should be
-applied to /dev/MAKEDEV and the script should then be re-run
-to create new entries for the ports.
---------------------------- CUT HERE ----------------------------
---- /dev/MAKEDEV	Sun Aug 20 10:51:55 1995
-+++ MAKEDEV.new	Fri Apr 19 06:48:12 1996
-@@ -206,8 +206,8 @@
- 		major2=`Major cub` || continue
- 		for i in 0 1 2 3 4 5 6 7 # 8 9 10 11 12 13 14 15
- 		do
--			makedev ttyC$i c $major1 `expr 32 + $i` $tty
--			makedev cub$i c $major2 `expr 32 + $i` $dialout
-+			makedev ttyC$i c $major1 $i $tty
-+			makedev cub$i c $major2 $i $dialout
- 		done
- 		;;
- 	par[0-2])
---------------------------- CUT HERE ----------------------------
-
-
