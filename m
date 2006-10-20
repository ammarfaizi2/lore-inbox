Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946768AbWJTA5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946768AbWJTA5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 20:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946767AbWJTA5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 20:57:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55229 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1946753AbWJTA5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 20:57:40 -0400
Date: Fri, 20 Oct 2006 01:57:37 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061020005737.GW29920@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org> <20061018160609.GO29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org> <20061020005337.GV29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020005337.GV29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's just a dead weight these days
---
 include/asm-x86_64/uaccess.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86_64/uaccess.h b/include/asm-x86_64/uaccess.h
index 19f9917..d5dbc87 100644
--- a/include/asm-x86_64/uaccess.h
+++ b/include/asm-x86_64/uaccess.h
@@ -6,7 +6,6 @@ #define __X86_64_UACCESS_H
  */
 #include <linux/compiler.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/prefetch.h>
 #include <asm/page.h>
 
-- 
1.4.2.GIT

