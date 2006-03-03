Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWCCLAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWCCLAo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWCCLAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:00:44 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:3030 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751241AbWCCLAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:00:43 -0500
Message-ID: <440821C0.3050202@sonologic.nl>
Date: Fri, 03 Mar 2006 12:00:16 +0100
From: Koen Martens <gmc@sonologic.nl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 3/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, gmc@sonologic.nl, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added s3c2412 configuration item.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/arch/arm/mach-s3c2410/Kconfig    2006-02-10 
08:22:48.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/Kconfig    2006-02-27 
16:23:34.000000000 +0100
+config CPU_S3C2412
+    bool
+    depends on ARCH_S3C2410
+    help
+      Support for S3C2412 and S3C2413 family from the S3C24XX line
+      of Samsung Mobile CPUs.
+
 config CPU_S3C2440
     bool
     depends on ARCH_S3C2410

