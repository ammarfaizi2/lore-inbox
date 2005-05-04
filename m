Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVEDSpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVEDSpm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVEDSpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:45:42 -0400
Received: from verein.lst.de ([213.95.11.210]:25067 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261380AbVEDSpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:45:36 -0400
Date: Wed, 4 May 2005 20:45:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove outdated comments from filemap.c
Message-ID: <20050504184531.GB20671@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- 1.296/mm/filemap.c	2005-03-05 07:41:15 +01:00
+++ edited/mm/filemap.c	2005-03-07 06:09:52 +01:00
@@ -29,11 +29,6 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 /*
- * This is needed for the following functions:
- *  - try_to_release_page
- *  - block_invalidatepage
- *  - generic_osync_inode
- *
  * FIXME: remove all knowledge of the buffer layer from the core VM
  */
 #include <linux/buffer_head.h> /* for generic_osync_inode */
