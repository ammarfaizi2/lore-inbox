Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267792AbTAHJuD>; Wed, 8 Jan 2003 04:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267793AbTAHJuC>; Wed, 8 Jan 2003 04:50:02 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:6 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267792AbTAHJtj>; Wed, 8 Jan 2003 04:49:39 -0500
Date: Wed, 8 Jan 2003 09:57:50 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/10] dm: Remove explicit returns from void fns (fluff)
Message-ID: <20030108095750.GG2063@reti>
References: <20030108095221.GA2063@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108095221.GA2063@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove explicit return at the end of a couple of void functions.
--- diff/drivers/md/dm-target.c	2003-01-02 11:26:27.000000000 +0000
+++ source/drivers/md/dm-target.c	2003-01-02 11:26:44.000000000 +0000
@@ -66,8 +66,6 @@
 
 	strcat(module_name, name);
 	request_module(module_name);
-
-	return;
 }
 
 struct target_type *dm_get_target_type(const char *name)
@@ -161,7 +159,6 @@
 static void io_err_dtr(struct dm_target *ti)
 {
 	/* empty */
-	return;
 }
 
 static int io_err_map(struct dm_target *ti, struct bio *bio)
