Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUIGPRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUIGPRn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268356AbUIGPNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:13:48 -0400
Received: from verein.lst.de ([213.95.11.210]:48538 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268179AbUIGPK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:10:57 -0400
Date: Tue, 7 Sep 2004 17:10:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport lookup_create
Message-ID: <20040907151052.GA9577@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

besides namei.c it's only used in the SN2 hwgraph code which can't be
modular (and will be removed soon)


--- 1.107/fs/namei.c	2004-09-01 01:00:48 +02:00
+++ edited/fs/namei.c	2004-09-07 13:57:28 +02:00
@@ -2386,7 +2386,6 @@
 EXPORT_SYMBOL(get_write_access); /* binfmt_aout */
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(lock_rename);
-EXPORT_SYMBOL(lookup_create);
 EXPORT_SYMBOL(lookup_hash);
 EXPORT_SYMBOL(lookup_one_len);
 EXPORT_SYMBOL(page_follow_link);
