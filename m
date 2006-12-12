Return-Path: <linux-kernel-owner+w=401wt.eu-S1751497AbWLLQWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWLLQWW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWLLQWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:22:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3370 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751497AbWLLQWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:22:21 -0500
Date: Tue, 12 Dec 2006 17:22:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] one more EXPORT_UNUSED_SYMBOL removal
Message-ID: <20061212162230.GP28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-mm1/fs/read_write.c.old	2006-12-12 14:41:43.000000000 +0100
+++ linux-2.6.19-mm1/fs/read_write.c	2006-12-12 14:41:50.000000000 +0100
@@ -450,8 +450,6 @@
 	return seg;
 }
 
-EXPORT_UNUSED_SYMBOL(iov_shorten);  /*  June 2006  */
-
 ssize_t do_sync_readv_writev(struct file *filp, const struct iovec *iov,
 		unsigned long nr_segs, size_t len, loff_t *ppos, iov_fn_t fn)
 {

