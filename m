Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267007AbTBTVo4>; Thu, 20 Feb 2003 16:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbTBTVo4>; Thu, 20 Feb 2003 16:44:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45830 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267007AbTBTVoz>; Thu, 20 Feb 2003 16:44:55 -0500
Date: Thu, 20 Feb 2003 22:53:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Fix kernel commandline documentation
Message-ID: <20030220214805.GA18374@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was searching for pci=noacpi, and, well, it is in .c but not in
documentation. Here's fix, please apply. [The killed line is there to
preserve consystency with rest of text].

								Pavel

--- linux/Documentation/kernel-parameters.txt	2003-02-11 17:43:27.000000000 +0100
+++ linux-tablet/Documentation/kernel-parameters.txt	2003-02-20 21:42:28.000000000 +0100
@@ -703,7 +703,6 @@
 					numbers ourselves, overriding
 					whatever the firmware may have
 					done.
-
 		usepirqmask		[IA-32] Honor the possible IRQ mask
 					stored in the BIOS $PIR table. This is
 					needed on some systems with broken
@@ -711,6 +710,7 @@
 					and Omnibook XE3 notebooks. This will
 					have no effect if ACPI IRQ routing is
 					enabled.
+		noacpi			[IA-32] Do not use ACPI for IRQ routing.
 
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
