Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265297AbUEZEBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbUEZEBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 00:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUEZEBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 00:01:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:43159 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265297AbUEZEBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 00:01:38 -0400
Date: Tue, 25 May 2004 20:58:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] remove message: POSIX conformance testing by UNIFIX
Message-Id: <20040525205820.25338dd5.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove the outdated "POSIX conformance testing by UNIFIX" message.

There is a general desire to reduce the quantity of noisy and/or
outdated kernel boot-time messages...

Suggested by Andi Kleen.

Ulrich's (old) comments:
http://www.nsa.gov/selinux/list-archive/0107/0525.cfm

Certifying Linux (Linux Journal):
http://www.linuxjournal.com/article.php?sid=0131

Agreed by Tim Bird, no dissenters that I heard of:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108362954024749&w=2


diffstat:=
 init/main.c |    1 -
 1 files changed, 1 deletion(-)

diff -Naurp ./init/main.c~unifix-message-delete ./init/main.c
--- ./init/main.c~unifix-message-delete	2004-05-23 18:13:07.000000000 -0700
+++ ./init/main.c	2004-05-25 20:45:45.000000000 -0700
@@ -481,7 +481,6 @@ asmlinkage void __init start_kernel(void
 	proc_root_init();
 #endif
 	check_bugs();
-	printk("POSIX conformance testing by UNIFIX\n");
 
 	/* 
 	 *	We count on the initial thread going ok 


--
~Randy
