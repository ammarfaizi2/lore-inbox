Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316476AbSEWM3z>; Thu, 23 May 2002 08:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316584AbSEWM1z>; Thu, 23 May 2002 08:27:55 -0400
Received: from imladris.infradead.org ([194.205.184.45]:42762 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316538AbSEWM1P>; Thu, 23 May 2002 08:27:15 -0400
Date: Thu, 23 May 2002 13:27:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include buffer_head.h in actual users instead of fs.h (8/10)
Message-ID: <20020523132710.I24361@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make kernel/ksyms.c include buffer_head.h directly.


--- 1.92/kernel/ksyms.c	Wed May 22 17:48:14 2002
+++ edited/kernel/ksyms.c	Thu May 23 13:25:24 2002
@@ -48,6 +48,7 @@
 #include <linux/seq_file.h>
 #include <linux/binfmts.h>
 #include <linux/namei.h>
+#include <linux/buffer_head.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
