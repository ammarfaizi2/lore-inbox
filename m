Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVCPV32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVCPV32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVCPV14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:27:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:8120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262808AbVCPV0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:26:44 -0500
Date: Wed, 16 Mar 2005 13:26:29 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, ak@suse.de
Subject: [PATCH] kernel-parameters: IA-32/X86-64 cleanups
Message-Id: <20050316132629.3e09bd9d.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert "kernel-parameters.txt" to use IA-32 in place of x86
  and X86-64 in place of x86_64, to be in line with other
  architecture documentation conventions.
Add reference to Documentation/x86_64/boot-options.txt .

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 Documentation/kernel-parameters.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff -Naurp ./Documentation/kernel-parameters.txt~kernprms_x86_64 ./Documentation/kernel-parameters.txt
--- ./Documentation/kernel-parameters.txt~kernprms_x86_64	2005-03-15 21:21:20.000000000 -0800
+++ ./Documentation/kernel-parameters.txt	2005-03-15 21:37:43.000000000 -0800
@@ -78,6 +78,9 @@ restrictions referred to are that the re
 	VT	Virtual terminal support is enabled.
 	WDT	Watchdog support is enabled.
 	XT	IBM PC/XT MFM hard disk support is enabled.
+	X86-64	X86-64 architecture is enabled.
+			More X86-64 boot options can be found in
+			Documentation/x86_64/boot-options.txt .
 
 In addition, the following text indicates that the option:
 
@@ -396,7 +396,7 @@ running once the system is up.
 
 	dtc3181e=	[HW,SCSI]
 
-	earlyprintk=	[x86, x86_64]
+	earlyprintk=	[IA-32, X86-64]
 			earlyprintk=vga
 			earlyprintk=serial[,ttySn[,baudrate]]
 
@@ -831,7 +831,7 @@ running once the system is up.
 
 	noexec		[IA-64]
 
-	noexec		[i386, x86_64]
+	noexec		[IA-32, X86-64]
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable nn-executable mappings
 

---
