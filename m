Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKQXwz>; Fri, 17 Nov 2000 18:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129302AbQKQXwq>; Fri, 17 Nov 2000 18:52:46 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:60656 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S129145AbQKQXwd>; Fri, 17 Nov 2000 18:52:33 -0500
Date: Sat, 18 Nov 2000 00:24:17 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [patchlet] fix some typos and pathnames in Configure.help (fwd)
Message-ID: <Pine.LNX.4.21.0011180023080.10790-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this fixes some typos and pathnames in pointers from Configure.help to
files in the Documentation subtree.
Not much, but better than nothing.
Diff is against 2.4.0-test10.

Matthias


--- Documentation/Configure.help.orig	Sat Nov 18 00:14:01 2000
+++ Documentation/Configure.help	Fri Nov 17 23:35:47 2000
@@ -77,7 +77,7 @@
   in some special cases. Detailed bug reports from people familiar
   with the kernel internals are usually welcomed by the developers
   (before submitting bug reports, please read the documents README,
-  MAINTAINERS, REPORTING_BUGS, Documentation/BUG-HUNTING, and
+  MAINTAINERS, REPORTING-BUGS, Documentation/BUG-HUNTING, and
   Documentation/oops-tracing.txt in the kernel source). 
 
   This option will also make obsoleted drivers available. These are
@@ -113,7 +113,7 @@
   Management" code will be disabled if you say Y here.
 
   See also the files Documentation/smp.tex, Documentation/smp.txt,
-  Documentation/IO-APIC.txt, Documentation/nmi_watchdog.txt and the 
+  Documentation/i386/IO-APIC.txt, Documentation/nmi_watchdog.txt and the 
   SMP-FAQ on the WWW at http://www.irisa.fr/prive/mentre/smp-faq/ .
   
   If you don't know what to do here, say N.
@@ -3471,7 +3471,7 @@
   The module will be called parport.o. If you have more than one
   parallel port and want to specify which port and IRQ to be used by
   this driver at module load time, take a look at
-  Documentation/networking/parport.txt.
+  Documentation/parport.txt.
 
   If unsure, say Y.
 
@@ -3614,7 +3614,7 @@
   "Sysctl support" below, you can change various aspects of the
   behavior of the TCP/IP code by writing to the (virtual) files in
   /proc/sys/net/ipv4/*; the options are explained in the file
-  Documentation/Networking/ip-sysctl.txt.
+  Documentation/networking/ip-sysctl.txt.
 
   Short answer: say Y.
 
@@ -4995,7 +4995,7 @@
 CONFIG_BLK_CPQ_CISS_DA
    This is the driver for Compaq Smart Array controllers.
    Everyone using these boards should say Y here.
-   See "linux/Documentation/cciss.txt" for the current list of
+   See Documentation/cciss.txt for the current list of
    boards supported by this driver, and for further information
    on the use of this driver.
 
@@ -13995,7 +13995,7 @@
 SGI Visual Workstation on-board audio
 CONFIG_SOUND_VWSND
   Say Y or M if you have an SGI Visual Workstation and you want to
-  be able to use its on-board audio.  Read Documentation/sound/visws
+  be able to use its on-board audio.  Read Documentation/sound/vwsnd
   for more info on this driver's capabilities.
 
 Ensoniq Soundscape support



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
