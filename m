Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313176AbSC1PCh>; Thu, 28 Mar 2002 10:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313177AbSC1PC1>; Thu, 28 Mar 2002 10:02:27 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:20383 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S313176AbSC1PCP>; Thu, 28 Mar 2002 10:02:15 -0500
Subject: [PATCH] 2.5.7-dj2 add 5 help texts to arch/ia64/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: davidm@hpl.hp.com
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 Mar 2002 07:59:08 -0700
Message-Id: <1017327548.1946.23.camel@spc.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 5 help texts to arch/ia64/Config.help.
The texts were obtained from Eric S. Raymond's v2.97 Configure.help.

Steven

--- linux-2.5.7-dj2/arch/ia64/Config.help.orig	Thu Mar 28 07:49:26 2002
+++ linux-2.5.7-dj2/arch/ia64/Config.help	Thu Mar 28 07:50:38 2002
@@ -440,6 +440,32 @@
   with a B-step CPU.  You have a B-step CPU if the "revision" field in
   /proc/cpuinfo has a value in the range from 1 to 4.
 
+CONFIG_IA64_SGI_AUTOTEST
+  Build a kernel used for hardware validation. If you include the
+  keyword "autotest" on the boot command line, the kernel does NOT boot.
+  Instead, it starts all cpus and runs cache coherency tests instead.
+
+  If unsure, say N.
+
+CONFIG_IA64_SGI_SN_DEBUG
+  Turns on extra debugging code in the SGI SN (Scalable NUMA) platform
+  for IA64.  Unless you are debugging problems on an SGI SN IA64 box,
+  say N.
+
+CONFIG_IA64_SGI_SN_SIM
+  If you are compiling a kernel that will run under SGI's IA64
+  simulator (Medusa) then say Y, otherwise say N.
+
+CONFIG_SERIAL_SGI_L1_PROTOCOL
+  Uses protocol mode instead of raw mode for the level 1 console on the
+  SGI SN (Scalable NUMA) platform for IA64.  If you are compiling for
+  an SGI SN box then Y is the recommended value, otherwise say N.
+
+CONFIG_PCIBA
+  IRIX PCIBA-inspired user mode PCI interface for the SGI SN (Scalable
+  NUMA) platform for IA64.  Unless you are compiling a kernel for an
+  SGI SN IA64 box, say N.
+
 CONFIG_IA64_MCA
   Say Y here to enable machine check support for IA-64.  If you're
   unsure, answer Y.


