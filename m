Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267786AbTAHJwE>; Wed, 8 Jan 2003 04:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267794AbTAHJwD>; Wed, 8 Jan 2003 04:52:03 -0500
Received: from cmailm1.svr.pol.co.uk ([195.92.193.18]:33549 "EHLO
	cmailm1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267786AbTAHJvm>; Wed, 8 Jan 2003 04:51:42 -0500
Date: Wed, 8 Jan 2003 09:59:53 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/10] dm: Export dm_table_get_mode()
Message-ID: <20030108095953.GJ2063@reti>
References: <20030108095221.GA2063@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108095221.GA2063@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export dm_table_get_mode()
--- diff/drivers/md/dm-table.c	2003-01-02 11:26:53.000000000 +0000
+++ source/drivers/md/dm-table.c	2003-01-02 11:27:13.000000000 +0000
@@ -751,3 +751,4 @@
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);
 EXPORT_SYMBOL(dm_table_event);
+EXPORT_SYMBOL(dm_table_get_mode);
