Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316475AbSEWM3y>; Thu, 23 May 2002 08:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316486AbSEWM2P>; Thu, 23 May 2002 08:28:15 -0400
Received: from imladris.infradead.org ([194.205.184.45]:43274 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316471AbSEWM1t>; Thu, 23 May 2002 08:27:49 -0400
Date: Thu, 23 May 2002 13:27:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include buffer_head.h in actual users instead of fs.h (10/10)
Message-ID: <20020523132746.J24361@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No more need to include buffer_head.h in fs.h.  Finally.


--- 1.121/include/linux/fs.h	Wed May 22 20:57:10 2002
+++ edited/include/linux/fs.h	Thu May 23 14:18:04 2002
@@ -1283,8 +1283,5 @@
 	return res;
 }
 
-#include <linux/buffer_head.h>
-
 #endif /* __KERNEL__ */
-
 #endif /* _LINUX_FS_H */
