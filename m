Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264159AbUECXL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264159AbUECXL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUECXL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:11:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:6859 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264161AbUECXLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:11:12 -0400
Date: Mon, 3 May 2004 16:03:47 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] delete "POSIX conformance testing by UNIFIX" message
Message-Id: <20040503160347.088af84e.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


// linux-266-rc3
// delete the POSIX UNIFIX conformance testing message;

There is a general desire to reduce the quantity of noisy and/or
outdated kernel boot-time messages...

Suggested by Andi Kleen.

Ulrich's (old) comments:
http://www.nsa.gov/selinux/list-archive/0107/0525.cfm

Certifying Linux (Linux Journal):
http://www.linuxjournal.com/article.php?sid=0131


Other comments?


diffstat:=
 init/main.c |    1 -
 1 files changed, 1 deletion(-)


diff -Naurp ./init/main.c~unifix-gone ./init/main.c
--- ./init/main.c~unifix-gone	2004-04-20 15:54:30.000000000 -0700
+++ ./init/main.c	2004-05-03 14:34:59.000000000 -0700
@@ -476,7 +476,6 @@ asmlinkage void __init start_kernel(void
 	proc_root_init();
 #endif
 	check_bugs();
-	printk("POSIX conformance testing by UNIFIX\n");
 
 	/* 
 	 *	We count on the initial thread going ok 
