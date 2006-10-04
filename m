Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161907AbWJDSCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161907AbWJDSCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWJDSAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:00:04 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:48117 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161813AbWJDR7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:59:35 -0400
Date: Wed, 4 Oct 2006 19:59:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Remove crept in whitespace from head*.S again.
Message-ID: <20061004175937.GG26756@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Remove crept in whitespace from head*.S again.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/head31.S |    8 ++++----
 arch/s390/kernel/head64.S |   12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
--- linux-2.6/arch/s390/kernel/head31.S	2006-10-04 19:53:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head31.S	2006-10-04 19:53:50.000000000 +0200
@@ -258,10 +258,10 @@ startup_continue:
 # find out if the diag 0x9c is available
 #
 	mvc	__LC_PGM_NEW_PSW(8),.Lpcdiag9c-.LPG1(%r13)
-	stap   __LC_CPUID+4		# store cpu address
-	lh     %r1,__LC_CPUID+4
-	diag   %r1,0,0x9c		# test diag 0x9c
-	oi     2(%r12),1		# set diag9c flag
+	stap	__LC_CPUID+4		# store cpu address
+	lh	%r1,__LC_CPUID+4
+	diag	%r1,0,0x9c		# test diag 0x9c
+	oi	2(%r12),1		# set diag9c flag
 .Lchkdiag9c:
 
 	lpsw  .Lentry-.LPG1(13)		# jump to _stext in primary-space,
diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2006-10-04 19:53:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-10-04 19:53:50.000000000 +0200
@@ -253,12 +253,12 @@ startup_continue:
 #
 # find out if the diag 0x9c is available
 #
-	la     %r1,0f-.LPG1(%r13)	# set program check address
-	stg    %r1,__LC_PGM_NEW_PSW+8
-	stap   __LC_CPUID+4		# store cpu address
-	lh     %r1,__LC_CPUID+4
-	diag   %r1,0,0x9c		# test diag 0x9c
-	oi     6(%r12),1		# set diag9c flag
+	la	%r1,0f-.LPG1(%r13)	# set program check address
+	stg	%r1,__LC_PGM_NEW_PSW+8
+	stap	__LC_CPUID+4		# store cpu address
+	lh	%r1,__LC_CPUID+4
+	diag	%r1,0,0x9c		# test diag 0x9c
+	oi	6(%r12),1		# set diag9c flag
 0:
 
 #
