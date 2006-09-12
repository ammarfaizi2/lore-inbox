Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWILJja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWILJja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWILJja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:39:30 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:20360 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965160AbWILJja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:39:30 -0400
Date: Tue, 12 Sep 2006 11:39:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Remove kexec experimental flag.
Message-ID: <20060912093927.GA15641@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Remove kexec experimental flag.

Follow other architectures and remove kexec experimental flag.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-09-12 10:57:28.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2006-09-12 10:57:52.000000000 +0200
@@ -456,8 +456,7 @@ config S390_HYPFS_FS
 	  information in an s390 hypervisor environment.
 
 config KEXEC
-	bool "kexec system call (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	bool "kexec system call"
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
