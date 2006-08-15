Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWHOA0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWHOA0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbWHOA0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:26:24 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:29063 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932754AbWHOA0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:26:23 -0400
Subject: [PATCH] rcu: Add MODULE_AUTHOR to rcutorture module
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Dipkanar Sarma <dipankar@in.ibm.com>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 17:26:15 -0700
Message-Id: <1155601575.5557.30.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 kernel/rcutorture.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index 4d1c3d2..16b5899 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -46,6 +46,7 @@ #include <linux/byteorder/swabb.h>
 #include <linux/stat.h>
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Paul E. McKenney <paulmck@us.ibm.com>");
 
 static int nreaders = -1;	/* # reader threads, defaults to 4*ncpus */
 static int stat_interval;	/* Interval between stats, in seconds. */


