Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUBGL0W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 06:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUBGL0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 06:26:22 -0500
Received: from dsl-hkigw4m08.dial.inet.fi ([80.222.60.8]:42116 "EHLO
	dsl-hkigw4m08.dial.inet.fi") by vger.kernel.org with ESMTP
	id S266846AbUBGL0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 06:26:16 -0500
Date: Sat, 7 Feb 2004 13:26:15 +0200 (EET)
From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-hkigw4m08.dial.inet.fi
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Trivial Patch Collection <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] unify cpufreq Kconfig file reference with other documentation
Message-ID: <Pine.LNX.4.58.0402071315450.9462@dsl-hkigw4m08.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr. Jones,

I would like to unify cpufreq Kconfig file references to documentation
with rest of Linux kernel documentation.

Best regards,
Petri Koistinen

--- linux-2.6/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-02-05 17:01:20.000000000 +0200
+++ linux-2.6-trivial/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-02-07 13:14:11.000000000 +0200
@@ -11,8 +11,8 @@
 	  fly. This is a nice method to save battery power on notebooks,
 	  because the lower the clock speed, the less power the CPU consumes.

-	  For more information, take a look at linux/Documentation/cpu-freq or
-	  at <http://www.codemonkey.org.uk/projects/cpufreq/>
+	  For more information, take a look at <file:Documentation/cpu-freq/>
+	  or at <http://www.codemonkey.org.uk/projects/cpufreq/>

 	  If in doubt, say N.

@@ -38,7 +38,7 @@
 	  This driver adds a CPUFreq driver which utilizes the ACPI
 	  Processor Performance States.

-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq/>.

 	  If in doubt, say N.

@@ -63,7 +63,7 @@
 	  parameter: elanfreq=maxspeed (in kHz) or as module
 	  parameter "max_freq".

-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq/>.

 	  If in doubt, say N.

@@ -74,7 +74,7 @@
 	  This adds the CPUFreq driver for mobile AMD K6-2+ and mobile
 	  AMD K6-3+ processors.

-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq/>.

 	  If in doubt, say N.

@@ -84,7 +84,7 @@
 	help
 	  This adds the CPUFreq driver for mobile AMD K7 mobile processors.

-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq/>.

 	  If in doubt, say N.

@@ -94,7 +94,7 @@
 	help
 	  This adds the CPUFreq driver for mobile AMD Opteron/Athlon64 processors.

-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq/>.

 	  If in doubt, say N.

@@ -105,7 +105,7 @@
 	 This add the CPUFreq driver for NatSemi Geode processors which
 	 support suspend modulation.

-	 For details, take a look at linux/Documentation/cpu-freq.
+	 For details, take a look at <file:Documentation/cpu-freq/>.

 	 If in doubt, say N.

@@ -116,7 +116,7 @@
 	  This adds the CPUFreq driver for Enhanced SpeedStep enabled
 	  mobile CPUs.  This means Intel Pentium M (Centrino) CPUs.

-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq/>.

 	  If in doubt, say N.

@@ -129,7 +129,7 @@
 	  mobile Intel Pentium 4 P4-M on systems which have an Intel ICH2,
 	  ICH3 or ICH4 southbridge.

-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq/>.

 	  If in doubt, say N.

@@ -141,7 +141,7 @@
 	  (Coppermine), all mobile Intel Pentium III-M (Tualatin)
 	  on systems which have an Intel 440BX/ZX/MX southbridge.

-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq/>.

 	  If in doubt, say N.

@@ -152,7 +152,7 @@
 	  This adds the CPUFreq driver for Intel Pentium 4 / XEON
 	  processors.

-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq/>.

 	  If in doubt, say N.

@@ -168,7 +168,7 @@
 	  This adds the CPUFreq driver for Transmeta Crusoe processors which
 	  support LongRun.

-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq/>.

 	  If in doubt, say N.

@@ -180,7 +180,7 @@
 	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T
 	  processors.

-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq/>.

 	  If in doubt, say N.

