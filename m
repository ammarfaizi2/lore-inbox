Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313183AbSDYQCw>; Thu, 25 Apr 2002 12:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313258AbSDYQCv>; Thu, 25 Apr 2002 12:02:51 -0400
Received: from tstac.esa.lanl.gov ([128.165.46.3]:47246 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S313183AbSDYQCu>; Thu, 25 Apr 2002 12:02:50 -0400
Subject: [PATCH] 2.5.9-dj1, add one help text to arch/ia64/Config.help.
From: Steven Cole <elenstev@mesatop.com>
To: davidm@hpl.hp.com
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 25 Apr 2002 09:58:27 -0600
Message-Id: <1019750313.2540.15.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a help text to arch/ia64/Config.help.
The CONFIG_IA64_GRANULE_16MB choice option is under the "Kernel hacking"
section for the IA64 arch.  Here is a snippet from arch/ia64/config.in:

choice 'Physical memory granularity'                            \
        "16MB                   CONFIG_IA64_GRANULE_16MB        \
         64MB                   CONFIG_IA64_GRANULE_64MB" 64MB

The help text was based loosely on the one found in 2.4.19-pre7 Configure.help.

Steven

--- linux-2.5.9-dj1/arch/ia64/Config.help.orig	Thu Apr 25 09:26:44 2002
+++ linux-2.5.9-dj1/arch/ia64/Config.help	Thu Apr 25 09:44:52 2002
@@ -557,3 +557,8 @@
   best used in conjunction with the NMI watchdog so that spinlock
   deadlocks are also debuggable.
 
+CONFIG_IA64_GRANULE_16MB
+  IA64 identity-mapped regions use a large page size called "granules".
+
+  Select "16MB" for a small granule size.
+  Select "64MB" for a large granule size.  This is the current default.





