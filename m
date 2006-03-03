Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWCCLCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWCCLCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWCCLCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:02:05 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:32468 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751244AbWCCLCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:02:04 -0500
Message-ID: <4408220A.705@metro.cx>
Date: Fri, 03 Mar 2006 12:01:30 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 4/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added s3c2412 object files.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/arch/arm/mach-s3c2410/Makefile    2006-02-10 
08:22:48.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/Makefile    2006-02-27 
17:10:25.000000000 +0100
@@ -20,24 +20,26 @@
 obj-$(CONFIG_PM)       += pm.o sleep.o
 obj-$(CONFIG_PM_SIMTEC)       += pm-simtec.o
 
+# S3C2412 support
+
+obj-$(CONFIG_CPU_S3C2412)  += s3c2412.o s3c2412-dsc.o
+
 # S3C2440 support
 
 obj-$(CONFIG_CPU_S3C2440)  += s3c2440.o s3c2440-dsc.o
 obj-$(CONFIG_CPU_S3C2440)  += s3c2440-irq.o
 obj-$(CONFIG_CPU_S3C2440)  += s3c2440-clock.o
 

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/

