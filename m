Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWJHOIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWJHOIr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWJHOIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:08:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43210 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751187AbWJHOIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:08:47 -0400
Date: Sun, 8 Oct 2006 15:08:45 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: [PATCH] linux/io.h needs types.h
Message-ID: <20061008140845.GY29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/io.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index aa3f5af..2ad96c3 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -18,6 +18,7 @@
 #ifndef _LINUX_IO_H
 #define _LINUX_IO_H
 
+#include <linux/types.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
-- 
1.4.2.GIT

