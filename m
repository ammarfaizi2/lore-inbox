Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWGFFSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWGFFSd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 01:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWGFFSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 01:18:33 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:17670 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S932247AbWGFFSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 01:18:32 -0400
Date: Thu, 6 Jul 2006 01:18:11 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH] more misc typo fixes
Message-Id: <20060706011811.3eef1a96.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Thu, 06 Jul 2006 01:18:17 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 06 Jul 2006 01:18:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are more misc typo fixes for the kernel.

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
kernel1@cyberdogtech.com

--

diff -ru a/arch/cris/arch-v10/drivers/Kconfig b/arch/cris/arch-v10/drivers/Kconfig
--- a/arch/cris/arch-v10/drivers/Kconfig	2006-07-05 23:55:13.000000000 -0400
+++ b/arch/cris/arch-v10/drivers/Kconfig	2006-07-06 00:49:08.000000000 -0400
@@ -550,7 +550,7 @@
 	select BLK_DEV_IDEDMA
 	help
 	  Enable this to get support for ATA/IDE.
-	  You can't use paralell ports or SCSI ports
+	  You can't use parallel ports or SCSI ports
 	  at the same time.
 
 
@@ -744,7 +744,7 @@
 	default "FF"
 	help
 	  This is a bitmask with information of what bits in PA that a user
-	  can change change the value on using ioctl's.
+	  can change the value on using ioctl's.
 	  Bit set = changeable.
 	  You probably want 00 here.
 
diff -ru a/arch/cris/arch-v32/Kconfig b/arch/cris/arch-v32/Kconfig
--- a/arch/cris/arch-v32/Kconfig	2006-07-05 23:55:13.000000000 -0400
+++ b/arch/cris/arch-v32/Kconfig	2006-07-06 00:20:37.000000000 -0400
@@ -162,7 +162,7 @@
 	depends on ETRAX_ARCH_V32
 	default "0"
 	help
-	  SDRAM configuration for group 1. The defult value is 0
+	  SDRAM configuration for group 1. The default value is 0
 	  because group 1 is not used in the default configuration,
 	  described in the help for SDRAM_GRP0_CONFIG.
 
diff -ru a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
--- a/arch/m68knommu/Kconfig	2006-07-05 23:57:07.000000000 -0400
+++ b/arch/m68knommu/Kconfig	2006-07-06 00:37:50.000000000 -0400
@@ -161,8 +161,8 @@
 	  frequency, it may or may not be the same as the external clock
 	  crystal fitted to your board. Some processors have an internal
 	  PLL and can have their frequency programmed at run time, others
-	  use internal dividers. In gernal the kernel won't setup a PLL
-	  if it is fitted (there are some expections). This value will be
+	  use internal dividers. In general the kernel won't setup a PLL
+	  if it is fitted (there are some exceptions). This value will be
 	  specific to the exact CPU that you are using.
 
 config CLOCK_DIV
diff -ru a/arch/um/Kconfig b/arch/um/Kconfig
--- a/arch/um/Kconfig	2006-07-05 23:55:11.000000000 -0400
+++ b/arch/um/Kconfig	2006-07-06 00:44:46.000000000 -0400
@@ -257,7 +257,7 @@
 	UML and spend long times with UML stopped at a breakpoint.  In this
 	case, when UML is restarted, it will call the timer enough times to make
 	up for the time spent at the breakpoint.  This could result in a
-	noticable lag.  If this is a problem, then disable this option.
+	noticeable lag.  If this is a problem, then disable this option.
 
 endmenu
 
diff -ru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	2006-07-05 23:57:10.000000000 -0400
+++ b/arch/x86_64/Kconfig	2006-07-06 00:28:11.000000000 -0400
@@ -292,7 +292,7 @@
        help
 	 Enable K8 NUMA node topology detection.  You should say Y here if
 	 you have a multi processor AMD K8 system. This uses an old
-	 method to read the NUMA configurtion directly from the builtin
+	 method to read the NUMA configuration directly from the builtin
 	 Northbridge of Opteron. It is recommended to use X86_64_ACPI_NUMA
 	 instead, which also takes priority if both are compiled in.   
 
diff -ru a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
--- a/drivers/input/joystick/Kconfig	2006-07-05 23:55:45.000000000 -0400
+++ b/drivers/input/joystick/Kconfig	2006-07-06 00:09:59.000000000 -0400
@@ -32,7 +32,7 @@
 	  module will be called analog.
 
 config JOYSTICK_A3D
-	tristate "Assasin 3D and MadCatz Panther devices"
+	tristate "Assassin 3D and MadCatz Panther devices"
 	select GAMEPORT
 	help
 	  Say Y here if you have an FPGaming or MadCatz controller using the
diff -ru a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	2006-07-05 23:57:42.000000000 -0400
+++ b/fs/Kconfig	2006-07-06 00:35:03.000000000 -0400
@@ -991,7 +991,7 @@
 	  on files and directories, and database-like indeces on selected
 	  attributes. (Also note that this driver doesn't make those features
 	  available at this time). It is a 64 bit filesystem, so it supports
-	  extremly large volumes and files.
+	  extremely large volumes and files.
 
 	  If you use this filesystem, you should also say Y to at least one
 	  of the NLS (native language support) options below.
diff -ru a/mm/Kconfig b/mm/Kconfig
--- a/mm/Kconfig	2006-07-05 23:58:03.000000000 -0400
+++ b/mm/Kconfig	2006-07-06 00:10:01.000000000 -0400
@@ -104,7 +104,7 @@
 	def_bool n
 
 #
-# Architectecture platforms which require a two level mem_section in SPARSEMEM
+# Architecture platforms which require a two level mem_section in SPARSEMEM
 # must select this option. This is usually for architecture platforms with
 # an extremely sparse physical address space.
 #
diff -ru a/net/ipv4/ipvs/Kconfig b/net/ipv4/ipvs/Kconfig
--- a/net/ipv4/ipvs/Kconfig	2006-07-05 23:55:08.000000000 -0400
+++ b/net/ipv4/ipvs/Kconfig	2006-07-06 00:31:51.000000000 -0400
@@ -81,7 +81,7 @@
 	bool "ESP load balancing support"
 	depends on IP_VS
 	---help---
-	  This option enables support for load balancing ESP (Encapsultion
+	  This option enables support for load balancing ESP (Encapsulation
 	  Security Payload) transport protocol. Say Y if unsure.
 
 config	IP_VS_PROTO_AH
diff -ru a/net/ipv4/Kconfig b/net/ipv4/Kconfig
--- a/net/ipv4/Kconfig	2006-07-05 23:58:03.000000000 -0400
+++ b/net/ipv4/Kconfig	2006-07-06 00:14:02.000000000 -0400
@@ -64,7 +64,7 @@
 config IP_FIB_TRIE
 	bool "FIB_TRIE"
 	---help---
-	Use new experimental LC-trie as FIB lookup algoritm. 
+	Use new experimental LC-trie as FIB lookup algorithm. 
         This improves lookup performance if you have a large
 	number of routes.
 
@@ -526,7 +526,7 @@
 	---help---
 	TCP-Hybla is a sender-side only change that eliminates penalization of
 	long-RTT, large-bandwidth connections, like when satellite legs are
-	involved, expecially when sharing a common bottleneck with normal
+	involved, especially when sharing a common bottleneck with normal
 	terrestrial connections.
 
 config TCP_CONG_VEGAS
diff -ru a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
--- a/net/ipv4/netfilter/Kconfig	2006-07-05 23:58:03.000000000 -0400
+++ b/net/ipv4/netfilter/Kconfig	2006-07-06 00:16:39.000000000 -0400
@@ -384,7 +384,7 @@
 	  daemon using netlink multicast sockets; unlike the LOG target
 	  which can only be viewed through syslog.
 
-	  The apropriate userspace logging daemon (ulogd) may be obtained from
+	  The appropriate userspace logging daemon (ulogd) may be obtained from
 	  <http://www.gnumonks.org/projects/ulogd/>
 
 	  To compile it as a module, choose M here.  If unsure, say N.
diff -ru a/security/selinux/Kconfig b/security/selinux/Kconfig
--- a/security/selinux/Kconfig	2006-07-05 23:58:04.000000000 -0400
+++ b/security/selinux/Kconfig	2006-07-06 00:47:09.000000000 -0400
@@ -112,7 +112,7 @@
 	  your distribution will provide these and enable the new controls
 	  in the kernel they also distribute.
 
-	  Note that this option can be overriden at boot with the
+	  Note that this option can be overridden at boot with the
 	  selinux_compat_net parameter, and after boot via
 	  /selinux/compat_net.  See Documentation/kernel-parameters.txt
 	  for details on this parameter.
diff -ru a/sound/oss/Kconfig b/sound/oss/Kconfig
--- a/sound/oss/Kconfig	2006-07-05 23:58:04.000000000 -0400
+++ b/sound/oss/Kconfig	2006-07-06 00:25:54.000000000 -0400
@@ -633,7 +633,7 @@
 	  command line.
 
 config PSS_MIXER
-	bool "Enable PSS mixer (Beethoven ADSP-16 and other compatibile)"
+	bool "Enable PSS mixer (Beethoven ADSP-16 and other compatible)"
 	depends on SOUND_PSS
 	help
 	  Answer Y for Beethoven ADSP-16. You may try to say Y also for other

