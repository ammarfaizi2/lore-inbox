Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWIIOn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWIIOn3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWIIOn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:43:29 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35715 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932228AbWIIOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:43:29 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 9 Sep 2006 16:42:14 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [RFC PATCH] MAINTAINERS: updates to IEEE 1394 subsystem
 maintainership
To: Jody McIntyre <scjody@modernduck.com>, Ben Collins <bcollins@debian.org>,
       Dan Dennedy <dan@dennedy.org>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <44D853AB.5050401@s5r6.in-berlin.de>
Message-ID: <tkrat.61ce92327b22c35a@s5r6.in-berlin.de>
References: <tkrat.c2b8d133bd52a5d9@s5r6.in-berlin.de>
 <1155005450.31278.46.camel@grayson.internal.net>
 <44D853AB.5050401@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Stefan Richter snatches Jody's place
 - update path to linux1394.org's repo
 - remove now redundant entries of ohci1394 and sbp2
 - promote eth1394 from Orphaned to Odd Fixes
 - Stefan takes patches to pcilynx but doesn't have the hardware

Rationale:  Reflect current practice.

Note, I am clueless about dv1394, video1394, and ohci1394's isochronous
parts.  But Dan and the driver authors will surely help when necessary.
Development in this field has shifted towards userspace anyway.  And I
am willing to learn.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Jody McIntyre <scjody@modernduck.com>
Cc: Ben Collins <bcollins@debian.org>
Cc: Dan Dennedy <dan@dennedy.org>
---

PS: On 2006-08-08 I wrote at linux1394-devel that I was not a suitable
subsystem maintainer due to lack of knowledge of the iso parts.  I have
reconsidered for above reason and because I hope I can contribute more
effectively with my contact listed at the subsystem entry.  I admit that
there were regressions to sbp2 during the past year of me maintaining it
(of the type "fix device A, break device B", particularly the more buggy
kind of B).  But the overall balance seems to be positive, and smoother
maintenance processes would mean less regressions after deployment.

If there are objections or reservations, please don't hold back.

Index: linux-2.6.18-rc6/MAINTAINERS
===================================================================
--- linux-2.6.18-rc6.orig/MAINTAINERS	2006-09-08 18:13:20.000000000 +0200
+++ linux-2.6.18-rc6/MAINTAINERS	2006-09-09 14:16:22.000000000 +0200
@@ -1365,36 +1365,29 @@ M:	Gadi Oxman <gadio@netvision.net.il>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
-IEEE 1394 ETHERNET (eth1394)
-L:	linux1394-devel@lists.sourceforge.net
-W:	http://www.linux1394.org/
-S:	Orphan
-
 IEEE 1394 SUBSYSTEM
 P:	Ben Collins
 M:	bcollins@debian.org
-P:	Jody McIntyre
-M:	scjody@modernduck.com
+P:	Stefan Richter
+M:	stefanr@s5r6.in-berlin.de
 L:	linux1394-devel@lists.sourceforge.net
 W:	http://www.linux1394.org/
-T:	git kernel.org:/pub/scm/linux/kernel/git/scjody/ieee1394.git
+T:	git kernel.org:/pub/scm/linux/kernel/git/bcollins/linux1394-2.6.git
 S:	Maintained
 
-IEEE 1394 OHCI DRIVER
-P:	Ben Collins
-M:	bcollins@debian.org
-P:	Jody McIntyre
-M:	scjody@modernduck.com
+IEEE 1394 IPV4 DRIVER (eth1394)
+P:	Stefan Richter
+M:	stefanr@s5r6.in-berlin.de
 L:	linux1394-devel@lists.sourceforge.net
-W:	http://www.linux1394.org/
-S:	Maintained
+S:	Odd Fixes
 
 IEEE 1394 PCILYNX DRIVER
 P:	Jody McIntyre
 M:	scjody@modernduck.com
+P:	Stefan Richter
+M:	stefanr@s5r6.in-berlin.de
 L:	linux1394-devel@lists.sourceforge.net
-W:	http://www.linux1394.org/
-S:	Maintained
+S:	Odd Fixes
 
 IEEE 1394 RAW I/O DRIVER
 P:	Ben Collins
@@ -1402,16 +1395,6 @@ M:	bcollins@debian.org
 P:	Dan Dennedy
 M:	dan@dennedy.org
 L:	linux1394-devel@lists.sourceforge.net
-W:	http://www.linux1394.org/
-S:	Maintained
-
-IEEE 1394 SBP2
-P:	Ben Collins
-M:	bcollins@debian.org
-P:	Stefan Richter
-M:	stefanr@s5r6.in-berlin.de
-L:	linux1394-devel@lists.sourceforge.net
-W:	http://www.linux1394.org/
 S:	Maintained
 
 IMS TWINTURBO FRAMEBUFFER DRIVER


