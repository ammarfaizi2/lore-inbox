Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWDODLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWDODLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 23:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWDODLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 23:11:16 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:36244 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030227AbWDODLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 23:11:05 -0400
Subject: [PATCH 07/08] percpu -v2 arch/x86_64/vmlinux.lds.h
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 23:11:03 -0400
Message-Id: <1145070663.27407.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linker script update for x86_64.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>


Index: linux-2.6.17-rc1/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.17-rc1.orig/arch/x86_64/kernel/vmlinux.lds.S	2006-04-03 16:21:20.000000000 -0400
+++ linux-2.6.17-rc1/arch/x86_64/kernel/vmlinux.lds.S	2006-04-14 18:53:58.000000000 -0400
@@ -51,6 +51,8 @@ SECTIONS
 	CONSTRUCTORS
 	}
 
+  PERCPU_OFFSET
+
   _edata = .;			/* End of data section */
 
   __bss_start = .;		/* BSS */


