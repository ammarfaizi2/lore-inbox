Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbULFRgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbULFRgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbULFRgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:36:23 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:36811 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261582AbULFReJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:34:09 -0500
Subject: PATCH: Intel/Cyrix typo
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102350635.14472.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Dec 2004 16:30:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Self explanatory:

Signed-off-by: Alan Cox <alan@redhat.com>
Based on a report on l/k

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9/arch/i386/Kconfig linux-2.6.9/arch/i386/Kconfig
--- linux.vanilla-2.6.9/arch/i386/Kconfig	2004-10-20 23:16:38.000000000 +0100
+++ linux-2.6.9/arch/i386/Kconfig	2004-11-25 23:06:10.000000000 +0000
@@ -199,7 +199,7 @@
 	bool "586/K5/5x86/6x86/6x86MX"
 	help
 	  Select this for an 586 or 686 series processor such as the AMD K5,
-	  the Intel 5x86 or 6x86, or the Intel 6x86MX.  This choice does not
+	  the Cyrix 5x86, 6x86 and 6x86MX.  This choice does not
 	  assume the RDTSC (Read Time Stamp Counter) instruction.
 
 config M586TSC

