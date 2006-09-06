Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWIFQlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWIFQlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbWIFQlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:41:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53449 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751646AbWIFQlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:41:11 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <fastboot@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH] i386 kexec: Remove experimental mark of kexec
Date: Wed, 06 Sep 2006 10:40:25 -0600
Message-ID: <m1zmddvthi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kexec has been marked experimental for a year now and all
of the serious kernel side problems have been worked through.  So it
is time (if not past time) to remove the experimental mark.
---
 arch/i386/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 798405f..4205437 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -765,8 +765,7 @@ config VGA_NOPROBE
 source kernel/Kconfig.hz
 
 config KEXEC
-	bool "kexec system call (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	bool "kexec system call"
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-- 
1.4.2.rc3.g7e18e-dirty

