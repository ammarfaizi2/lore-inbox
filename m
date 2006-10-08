Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWJHOEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWJHOEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWJHOEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:04:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:23708 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751185AbWJHOEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:04:15 -0400
Date: Sun, 8 Oct 2006 15:04:15 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing include of scatterlist.h
Message-ID: <20061008140415.GW29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/tifm.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/tifm.h b/include/linux/tifm.h
index 203dd5e..dfb8052 100644
--- a/include/linux/tifm.h
+++ b/include/linux/tifm.h
@@ -17,6 +17,7 @@ #include <linux/interrupt.h>
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/scatterlist.h>
 
 /* Host registers (relative to pci base address): */
 enum {
-- 
1.4.2.GIT

