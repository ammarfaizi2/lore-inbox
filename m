Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135175AbRDRNfT>; Wed, 18 Apr 2001 09:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135177AbRDRNfJ>; Wed, 18 Apr 2001 09:35:09 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:63749 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135175AbRDRNe4>;
	Wed, 18 Apr 2001 09:34:56 -0400
Date: Wed, 18 Apr 2001 09:35:53 -0400
Message-Id: <200104181335.f3IDZrq17002@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Supplying missing entries for Configure.help -- corrections
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some minor corrections to my Configure.help patches, as suggested by
lkml regulars.  Should be applied on top of my patches 1-4.

--- Configure.help	2001/04/18 05:27:07	1.5
+++ Configure.help	2001/04/18 13:21:24
@@ -96,7 +96,7 @@
 Prompt for drivers for obsolete features and hardware
 CONFIG_OBSOLETE
   Obsolete drivers have usually been replaced by more recent software that
-  can talk to the same hardware.  Obsolerte hardware is things like MGA 
+  can talk to the same hardware.  Obsolete hardware is things like MGA 
   monitors that you are very unlikely to see on today's systems.
 
 Symmetric Multi Processing
@@ -1631,14 +1631,14 @@
 
 Support for Cobalt Micro Server
 CONFIG_COBALT_MICRO_SERVER
-  Support for ARM-based Cobalt boxes (they have been bought by Sun and
+  Support for MIPS-based Cobalt boxes (they have been bought by Sun and
   are now the "Server Appliance Business Unit") including the 2700 series
   -- versions 1 of the Qube and Raq.  To compile a Linux kernel for this
   hardware, say Y here.
 
 Support for Cobalt 2800
 CONFIG_COBALT_28
-  Support for the second generation of ARM-based Cobalt boxes (they have
+  Support for the second generation of MIPS-based Cobalt boxes (they have
   been bought by Sun and are now the "Server Appliance Business Unit")
   including the 2800 series -- versions 2 of the Qube and Raq.  To compile
   a Linux kernel for this hardware, say Y here.
@@ -2979,13 +2979,6 @@
   called binfmt_aout.o. Saying M or N here is dangerous though,
   because some crucial programs on your system might still be in A.OUT
   format.
-
-Kernel support for JAVA binaries
-CONFIG_BINFMT_JAVA
-  If you answer Y here, the kernel's program loader will know how to
-  directly execute Java J-code.  This option is semi-obsolescent; you 
-  should probably use CONFIG_BINFMT_MISC and read Documentation/java.txt
-  for information about how to include Java support.
 
 Kernel support for Linux/Intel ELF binaries
 CONFIG_BINFMT_EM86
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The saddest life is that of a political aspirant under democracy. His
failure is ignominious and his success is disgraceful.
        -- H.L. Mencken
