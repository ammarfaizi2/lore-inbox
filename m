Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312759AbSCVREU>; Fri, 22 Mar 2002 12:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312760AbSCVREL>; Fri, 22 Mar 2002 12:04:11 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:56269 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S312759AbSCVRDu>; Fri, 22 Mar 2002 12:03:50 -0500
Subject: [PATCH] 2.5.7-dj1, add 4 help texts to drivers/s390/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 22 Mar 2002 10:01:02 -0700
Message-Id: <1016816462.2266.56.camel@spc.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds four help texts to drivers/s390/Config.help.
The texts were obtained from ESR's v2.97 Configure.help.

Steven

--- linux-2.5.7-dj1/drivers/s390/Config.help.orig	Fri Mar 22 09:43:48 2002
+++ linux-2.5.7-dj1/drivers/s390/Config.help	Fri Mar 22 09:54:14 2002
@@ -321,6 +321,18 @@
 CONFIG_DASD_FBA
   FBA devices are currently unsupported.
 
+CONFIG_DASD_AUTO_DIAG
+  Enable this option if you want your DIAG discipline module loaded
+  on DASD driver startup.
+
+CONFIG_DASD_AUTO_ECKD
+  Enable this option if you want your ECKD discipline module loaded
+  on DASD driver startup.
+
+CONFIG_DASD_AUTO_FBA
+  Enable this option if you want your FBA discipline module loaded
+  on DASD driver startup.
+
 CONFIG_TN3215
   Include support for IBM 3215 line-mode terminals.
 
@@ -342,6 +354,15 @@
 CONFIG_HWC_CONSOLE
   Include support for using an IBM HWC line-mode terminal as the Linux
   system console.
+
+CONFIG_HWC_CPI
+  This option enables the hardware console interface for system
+  identification This is commonly used for workload management and
+  gives you a nice name for the system on the service element.
+  Please select this option as a module since built-in operation is
+  completely untested. 
+  You should only select this option if you know what you are doing,
+  need this feature and intend to run your kernel in LPAR.
 
 CONFIG_S390_TAPE
   Select this option if you want to access channel-attached tape




