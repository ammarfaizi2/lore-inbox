Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262875AbVAFPzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbVAFPzD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVAFPzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:55:02 -0500
Received: from mfo06.iij.ad.jp ([210.130.1.94]:51435 "EHLO mfo06.iij.ad.jp")
	by vger.kernel.org with ESMTP id S262875AbVAFPyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:54:53 -0500
Date: Fri, 7 Jan 2005 00:11:39 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.10-mm2] mips: remove duplicate _end entry
Message-Id: <20050107001139.6b7aa56b.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had removed duplicate _end entry.

 * removed _end in include/asm-mips/sections.h

Only 2.6.10-mm2 need this patch.

diff -urN -X dontdiff b-orig/include/asm-mips/sections.h b/include/asm-mips/sections.h
--- b-orig/include/asm-mips/sections.h	Sat Dec 25 06:35:49 2004
+++ b/include/asm-mips/sections.h	Thu Jan  6 23:18:24 2005
@@ -4,6 +4,5 @@
 #include <asm-generic/sections.h>
 
 extern char _fdata;
-extern char _end;
 
 #endif /* _ASM_SECTIONS_H */
