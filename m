Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268120AbUIGOpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268120AbUIGOpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268122AbUIGOm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:42:57 -0400
Received: from verein.lst.de ([213.95.11.210]:38297 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268120AbUIGOjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:39:05 -0400
Date: Tue, 7 Sep 2004 16:39:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] don't export shmem_file_setup
Message-ID: <20040907143901.GB8606@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.161/mm/shmem.c	2004-09-03 11:08:25 +02:00
+++ edited/mm/shmem.c	2004-09-07 14:11:00 +02:00
@@ -2104,5 +2104,3 @@
 	vma->vm_ops = &shmem_vm_ops;
 	return 0;
 }
-
-EXPORT_SYMBOL(shmem_file_setup);
--- 1.1/mm/tiny-shmem.c	2004-08-31 10:00:08 +02:00
+++ edited/mm/tiny-shmem.c	2004-09-07 14:11:06 +02:00
@@ -120,5 +120,3 @@
 {
 	return 0;
 }
-
-EXPORT_SYMBOL(shmem_file_setup);
