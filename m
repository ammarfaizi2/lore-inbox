Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318110AbSFTD5M>; Wed, 19 Jun 2002 23:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318111AbSFTD5L>; Wed, 19 Jun 2002 23:57:11 -0400
Received: from catfish.lcs.mit.edu ([18.111.0.152]:57271 "EHLO
	catfish.lcs.mit.edu") by vger.kernel.org with ESMTP
	id <S318110AbSFTD5K>; Wed, 19 Jun 2002 23:57:10 -0400
Date: Wed, 19 Jun 2002 23:57:12 -0400 (EDT)
From: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.5.23: missing tqueue.h in cpia_pp.c
Message-ID: <Pine.GSO.4.10.10206192354190.24075-100000@catfish.lcs.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be another missing tqueue.h, this time in the CPIA video
driver.  The patch is against 2.5.23-dj2, but I believe it applies to
vanilla 2.5.23 as well.  Patch is appended; cc me on any replies.
 --scott

Boston Serbian assassination Nader COBRA JANE anthrax strategic Kojarena 
supercomputer OVER THE HORIZON RADAR NRA [Hello to all my fans in domestic surveillance] 
                         ( http://cscott.net/ )

diff -ruHp linux-2.5.23-dj2-orig/drivers/media/video/cpia_pp.c linux-2.5.23-dj2/drivers/media/video/cpia_pp.c
--- linux-2.5.23-dj2-orig/drivers/media/video/cpia_pp.c	Wed Jun 19 22:25:03 2002
+++ linux-2.5.23-dj2/drivers/media/video/cpia_pp.c	Wed Jun 19 22:35:14 2002
@@ -32,6 +32,7 @@
 #include <linux/parport.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/tqueue.h>
 #include <linux/smp_lock.h>
 
 #include <linux/kmod.h>

