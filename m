Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWJAKbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWJAKbe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWJAKbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:31:34 -0400
Received: from server6.greatnet.de ([83.133.96.26]:13025 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932213AbWJAKbd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:31:33 -0400
Message-ID: <451F98CB.3040509@nachtwindheim.de>
Date: Sun, 01 Oct 2006 12:30:35 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix in kerneldoc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an kerneldoc error.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff --git a/mm/filemap.c b/mm/filemap.c
index ec46923..f789500 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1139,11 +1139,11 @@ success:
 }
 
 /**
- * __generic_file_aio_read - generic filesystem read routine
+ * generic_file_aio_read - generic filesystem read routine
  * @iocb:	kernel I/O control block
  * @iov:	io vector request
  * @nr_segs:	number of segments in the iovec
- * @ppos:	current file position
+ * @pos:	current file position
  *
  * This is the "read()" routine for all filesystems
  * that can use the page cache directly.


