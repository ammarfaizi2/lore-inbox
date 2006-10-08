Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWJHOFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWJHOFR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWJHOFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:05:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37788 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751186AbWJHOFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:05:15 -0400
Date: Sun, 8 Oct 2006 15:05:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] missing forward declaration of pt_regs (asm-m68k/signal.h)
Message-ID: <20061008140514.GX29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-m68k/signal.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-m68k/signal.h b/include/asm-m68k/signal.h
index de1ba6e..3db8a81 100644
--- a/include/asm-m68k/signal.h
+++ b/include/asm-m68k/signal.h
@@ -198,6 +198,7 @@ static inline int sigfindinword(unsigned
 	return word ^ 31;
 }
 
+struct pt_regs;
 extern void ptrace_signal_deliver(struct pt_regs *regs, void *cookie);
 
 #endif /* __KERNEL__ */
-- 
1.4.2.GIT

