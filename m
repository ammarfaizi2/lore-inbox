Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268230AbUIGQJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268230AbUIGQJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268170AbUIGQIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:08:50 -0400
Received: from verein.lst.de ([213.95.11.210]:46490 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268290AbUIGPJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:09:43 -0400
Date: Tue, 7 Sep 2004 17:09:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport f_delown
Message-ID: <20040907150935.GA9552@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.40/fs/fcntl.c	2004-09-02 11:48:03 +02:00
+++ edited/fs/fcntl.c	2004-09-07 13:40:56 +02:00
@@ -290,8 +290,6 @@
 	f_modown(filp, 0, 0, 0, 1);
 }
 
-EXPORT_SYMBOL(f_delown);
-
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
