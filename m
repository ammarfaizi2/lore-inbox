Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135646AbRD1VPk>; Sat, 28 Apr 2001 17:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135644AbRD1VPg>; Sat, 28 Apr 2001 17:15:36 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:42500 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S135645AbRD1VPZ>;
	Sat, 28 Apr 2001 17:15:25 -0400
Message-ID: <20010428231336.A7635@bug.ucw.cz>
Date: Sat, 28 Apr 2001 23:13:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Typo in slab.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...and inocent one, but please apply, anyway.

							Pavel

Index: slab.h
===================================================================
RCS file: /home/cvs/Repository/linux/include/linux/slab.h,v
retrieving revision 1.1.1.2
diff -u -u -r1.1.1.2 slab.h
--- linux/include/linux/slab.h	2001/04/19 20:00:39	1.1.1.2
+++ linux/include/linux/slab.h	2001/04/28 20:11:52
@@ -29,7 +29,7 @@
  * The first 3 are only valid when the allocator as been build
  * SLAB_DEBUG_SUPPORT.
  */
-#define	SLAB_DEBUG_FREE		0x00000100UL	/* Peform (expensive) checks on free */
+#define	SLAB_DEBUG_FREE		0x00000100UL	/* Perform (expensive) checks on free */
 #define	SLAB_DEBUG_INITIAL	0x00000200UL	/* Call constructor (as verifier) */
 #define	SLAB_RED_ZONE		0x00000400UL	/* Red zone objs in a cache */
 #define	SLAB_POISON		0x00000800UL	/* Poison objects */
