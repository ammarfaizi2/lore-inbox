Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWIFQ4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWIFQ4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWIFQ4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:56:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56503 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751697AbWIFQ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:56:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <fastboot@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH] x86_64 kexec: Remove experimental mark of kexec
References: <m1veo1vtev.fsf@ebiederm.dsl.xmission.com>
Date: Wed, 06 Sep 2006 10:55:49 -0600
In-Reply-To: <m1veo1vtev.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Wed, 06 Sep 2006 10:42:00 -0600")
Message-ID: <m1k64hvsru.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kexec has been marked experimental for a year now and all
of the serious problems have been worked through.  So it
is time (if not past time) to remove the experimental mark.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

This time with a Signed-off-by line.

 arch/x86_64/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 756fa38..1adba0f 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -481,8 +481,7 @@ config X86_MCE_AMD
 	   the DRAM Error Threshold.
 
 config KEXEC
-	bool "kexec system call (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	bool "kexec system call"
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-- 
1.4.2.rc3.g7e18e-dirty

