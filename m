Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWF2Fdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWF2Fdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 01:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWF2Fdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 01:33:36 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:26890 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751609AbWF2Fdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 01:33:36 -0400
Date: Thu, 29 Jun 2006 01:32:47 -0400
From: Matt LaPlante <laplam@rpi.edu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] KConfig: Spellchecking 'similarity' and 'independent'
Message-Id: <20060629013247.c301a5ba.laplam@rpi.edu>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 01:32:55 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 01:32:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several KConfig files had 'similarity' and 'independent' spelled incorrectly...

-
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
laplam@rpi.edu

--

diff -ru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2006-06-29 00:23:23.000000000 -0400
+++ b/arch/i386/Kconfig	2006-06-29 00:40:56.000000000 -0400
@@ -737,7 +737,7 @@
 	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
-	  The name comes from the similiarity to the exec system call.
+	  The name comes from the similarity to the exec system call.
 
 	  It is an ongoing process to be certain the hardware in a machine
 	  is properly shutdown, so do not be surprised if this code does not
diff -ru a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig	2006-06-29 00:23:24.000000000 -0400
+++ b/arch/powerpc/Kconfig	2006-06-29 00:40:56.000000000 -0400
@@ -624,10 +624,10 @@
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.   And like a reboot
+	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
-	  The name comes from the similiarity to the exec system call.
+	  The name comes from the similarity to the exec system call.
 
 	  It is an ongoing process to be certain the hardware in a machine
 	  is properly shutdown, so do not be surprised if this code does not
diff -ru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2006-06-29 00:23:24.000000000 -0400
+++ b/arch/ppc/Kconfig	2006-06-29 00:40:56.000000000 -0400
@@ -219,10 +219,10 @@
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.   And like a reboot
+	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
-	  The name comes from the similiarity to the exec system call.
+	  The name comes from the similarity to the exec system call.
 
 	  It is an ongoing process to be certain the hardware in a machine
 	  is properly shutdown, so do not be surprised if this code does not
diff -ru a/arch/sh/Kconfig b/arch/sh/Kconfig
--- a/arch/sh/Kconfig	2006-06-20 05:31:55.000000000 -0400
+++ b/arch/sh/Kconfig	2006-06-29 00:40:56.000000000 -0400
@@ -465,10 +465,10 @@
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.  And like a reboot
+	  but it is independent of the system firmware.  And like a reboot
 	  you can start any kernel with it, not just Linux.
 
-	  The name comes from the similiarity to the exec system call.
+	  The name comes from the similarity to the exec system call.
 
 	  It is an ongoing process to be certain the hardware in a machine
 	  is properly shutdown, so do not be surprised if this code does not
diff -ru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	2006-06-29 00:23:24.000000000 -0400
+++ b/arch/x86_64/Kconfig	2006-06-29 00:40:56.000000000 -0400
@@ -459,10 +459,10 @@
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.   And like a reboot
+	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
-	  The name comes from the similiarity to the exec system call.
+	  The name comes from the similarity to the exec system call.
 
 	  It is an ongoing process to be certain the hardware in a machine
 	  is properly shutdown, so do not be surprised if this code does not

