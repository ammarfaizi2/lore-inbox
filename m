Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314061AbSDZOm5>; Fri, 26 Apr 2002 10:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314065AbSDZOm4>; Fri, 26 Apr 2002 10:42:56 -0400
Received: from 12-225-96-71.client.attbi.com ([12.225.96.71]:11136 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S314061AbSDZOm4>;
	Fri, 26 Apr 2002 10:42:56 -0400
Date: Fri, 26 Apr 2002 07:43:25 -0700
From: Jerry Cooperstein <coop@axian.com>
To: linux-kernel@vger.kernel.org
Subject: Minor typo in z2ram.c in 2.5 ; block_init_queue changes?
Message-ID: <20020426074325.A15546@p3.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uncovered the following minor typo:

--- z2ram.c     Wed Apr 24 00:15:20 2002
+++ z2ram.c_new Fri Apr 26 07:37:36 2002
@@ -366,7 +366,7 @@
            }
     }

-    blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUES, &z2ram_lock);
+    blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &z2ram_lock);
     blksize_size[ MAJOR_NR ] = z2_blocksizes;
     blk_size[ MAJOR_NR ] = z2_sizes;

Part  of changing blk_init_queue to take a third argument I guess.

======================================================================
 Jerry Cooperstein,  Senior Consultant <coop@axian.com>
 Axian, Inc.   <info@axian.com>
 4800 SW Griffith Dr., Ste. 202, Beaverton, OR  97005 USA
 http://www.axian.com/               Software Consulting and Training
======================================================================

