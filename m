Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031257AbWI0Xny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031257AbWI0Xny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031258AbWI0Xny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:43:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13788 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1031257AbWI0Xnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:43:53 -0400
Message-ID: <451B0CDB.8000203@engr.sgi.com>
Date: Wed, 27 Sep 2006 16:44:27 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, Greg Edwards <edwardsg@sgi.com>
Subject: [PATCH] update comments in linux/taskstats.h
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060508020206030105080508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508020206030105080508
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Andrew,

I was brought to attention that a change i made to linux/taskstats.h
invalidated the associated comments. So here is the patch that updates
the comments.

Signed-off-by: Jay Lan <jlan@sgi.com>


--------------060508020206030105080508
Content-Type: text/x-patch;
 name="csa-accounting-taskstats-update-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="csa-accounting-taskstats-update-fix.patch"

Index: linux/include/linux/taskstats.h
===================================================================
--- linux.orig/include/linux/taskstats.h	2006-09-27 15:51:07.000000000 -0700
+++ linux/include/linux/taskstats.h	2006-09-27 15:56:43.750129921 -0700
@@ -32,7 +32,7 @@
 
 
 #define TASKSTATS_VERSION	2
-#define TS_COMM_LEN		32	/* should sync up with TASK_COMM_LEN
+#define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
 struct taskstats {

--------------060508020206030105080508--
