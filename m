Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbUJXNHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbUJXNHu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUJXNHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:07:49 -0400
Received: from verein.lst.de ([213.95.11.210]:58021 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261471AbUJXNHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:07:42 -0400
Date: Sun, 24 Oct 2004 15:07:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport set_selection and paste_selection
Message-ID: <20041024130733.GC19488@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.11/drivers/char/selection.c	2004-09-14 15:29:10 +02:00
+++ edited/drivers/char/selection.c	2004-10-23 14:45:08 +02:00
@@ -304,6 +304,3 @@
 	tty_ldisc_deref(ld);
 	return 0;
 }
-
-EXPORT_SYMBOL(set_selection);
-EXPORT_SYMBOL(paste_selection);
