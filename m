Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSEWM3w>; Thu, 23 May 2002 08:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316475AbSEWM2H>; Thu, 23 May 2002 08:28:07 -0400
Received: from imladris.infradead.org ([194.205.184.45]:40714 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316476AbSEWM0v>; Thu, 23 May 2002 08:26:51 -0400
Date: Thu, 23 May 2002 13:26:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include buffer_head.h in actual users instead of fs.h (4/10)
Message-ID: <20020523132649.E24361@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two unused declarations in fs/jffs/intrep.h.


--- 1.3/fs/jffs/intrep.h	Tue Feb  5 08:49:33 2002
+++ edited/fs/jffs/intrep.h	Thu May 23 13:18:51 2002
@@ -85,7 +85,4 @@
 void jffs_print_hash_table(struct jffs_control *c);
 void jffs_print_tree(struct jffs_file *first_file, int indent);
 
-struct buffer_head *jffs_get_write_buffer(kdev_t dev, int block);
-void jffs_put_write_buffer(struct buffer_head *bh);
-
 #endif /* __LINUX_JFFS_INTREP_H__  */
