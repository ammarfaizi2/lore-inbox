Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbSLPKKN>; Mon, 16 Dec 2002 05:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbSLPKJS>; Mon, 16 Dec 2002 05:09:18 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:9744 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266716AbSLPKIq>; Mon, 16 Dec 2002 05:08:46 -0500
Date: Mon, 16 Dec 2002 10:16:52 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 16/19
Message-ID: <20021216101652.GQ7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove verbose debug message 'Splitting page'.
--- diff/drivers/md/dm.c	2002-12-16 09:41:25.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-16 09:41:34.000000000 +0000
@@ -339,8 +339,6 @@
 	struct bio *clone, *bio = ci->bio;
 	struct bio_vec *bv = bio->bi_io_vec + ci->idx;
 
-	DMWARN("splitting page");
-
 	if (len > ci->sector_count)
 		len = ci->sector_count;
 
