Return-Path: <linux-kernel-owner+w=401wt.eu-S937579AbWLKTOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937579AbWLKTOb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937595AbWLKTOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:14:31 -0500
Received: from iona.labri.fr ([147.210.8.143]:32977 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937579AbWLKTOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:14:30 -0500
Message-ID: <457DAE07.6090107@ens-lyon.org>
Date: Mon, 11 Dec 2006 20:14:15 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix typo in 'EXPERIMENTAL' in CC_STACKPROTECTOR on x86_64
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in 'EXPERIMENTAL' in config CC_STACKPROTECTOR in arch/x86_64/Kconfig.

Signed-off-by: <brice@myri.com>
---
 arch/x86_64/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.git/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.git.orig/arch/x86_64/Kconfig	2006-12-11 20:06:30.000000000 +0100
+++ linux-2.6.git/arch/x86_64/Kconfig	2006-12-11 20:07:06.000000000 +0100
@@ -584,7 +584,7 @@
 	  If unsure, say Y. Only embedded should say N here.
 
 config CC_STACKPROTECTOR
-	bool "Enable -fstack-protector buffer overflow detection (EXPRIMENTAL)"
+	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	help
          This option turns on the -fstack-protector GCC feature. This


