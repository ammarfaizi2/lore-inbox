Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267443AbUIAWhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267443AbUIAWhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUIAWeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:34:46 -0400
Received: from mail.dif.dk ([193.138.115.101]:55484 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267443AbUIAWcQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:32:16 -0400
Date: Thu, 2 Sep 2004 00:38:10 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Sort the CREDITS file properly   (and add myself)
Message-ID: <Pine.LNX.4.61.0409020025090.2724@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

Many entries in the CREDITS file are not properly sorted in alphabetical 
order, despite the note in the file that it is supposed to be sorted like 
that. 
This patch attempts to sort the CREDITS file properly. No existing entries 
were changed, merely moved around in the file. There where a few tricky 
names that I was unsure how to sort (names with characters such as ü, ö, 
and people with many names where it was unclear to me what name to sort by 
etc), in those cases I've usually left the names where they were unless it 
was glaringly obvious they were in the wrong spot.

I've also taken the liberty to add my own name to the file - I have 
contributed several tiny/small fixes/cleanups etc over the years, so I 
thought it would be OK - feel free to drop that part of the patch if you 
do not think this is warranted.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.9-rc1-bk6-orig/CREDITS linux-2.6.9-rc1-bk6/CREDITS
--- linux-2.6.9-rc1-bk6-orig/CREDITS	2004-09-02 00:21:25.000000000 +0200
+++ linux-2.6.9-rc1-bk6/CREDITS	2004-09-02 00:18:46.000000000 +0200
@@ -281,6 +281,11 @@
 S: Greenbelt, Maryland 20771
 S: USA
 
+N: Adam Belay
+E: ambx1@neo.rr.com
+D: Linux Plug and Play Support
+S: USA
+
 N: Daniele Bellucci
 E: bellucda@tiscali.it
 D: Various Janitor work.
@@ -513,6 +518,14 @@
 S: Oxford
 S: United Kingdom
 
+N: Luiz Fernando N. Capitulino
+E: lcapitulino@terra.com.br
+E: lcapitulino@prefeitura.sp.gov.br
+W: http://www.telecentros.sp.gov.br
+D: Little fixes and a lot of janitorial work
+S: E-GOV Telecentros SP
+S: Brazil
+
 N: Remy Card
 E: Remy.Card@masi.ibp.fr
 E: Remy.Card@linux.org
@@ -625,6 +638,14 @@
 D: Assorted sched/mm titbits
 S: Oxfordshire, UK.
 
+N: Kees Cook
+E: kees@outflux.net
+W: http://outflux.net/
+P: 1024D/17063E6D 9FA3 C49C 23C9 D1BC 2E30  1975 1FFF 4BA9 1706 3E6D
+D: Minor updates to SCSI code for the Communications type
+S: (ask for current address)
+S: USA
+
 N: Mark Corner
 E: mcorner@umich.edu
 W: http://www.eecs.umich.edu/~mcorner/
@@ -639,14 +660,6 @@
 S: Santa Cruz, California
 S: USA
 
-N: Kees Cook
-E: kees@outflux.net
-W: http://outflux.net/
-P: 1024D/17063E6D 9FA3 C49C 23C9 D1BC 2E30  1975 1FFF 4BA9 1706 3E6D
-D: Minor updates to SCSI code for the Communications type
-S: (ask for current address)
-S: USA
-
 N: Alan Cox
 W: http://www.linux.org.uk/diary/
 D: Linux Networking (0.99.10->2.0.29)
@@ -1055,6 +1068,12 @@
 S: 80050-430 - Curitiba - Paraná
 S: Brazil
 
+N: Kumar Gala
+E: kumar.gala@freescale.com
+D: Embedded PowerPC 6xx/7xx/74xx/82xx/85xx support
+S: Austin, Texas 78729
+S: USA
+
 N: Nigel Gamble
 E: nigel@nrg.org
 D: Interrupt-driven printer driver
@@ -1066,12 +1085,6 @@
 N: Jeff Garzik
 E: jgarzik@pobox.com
 
-N: Kumar Gala
-E: kumar.gala@freescale.com
-D: Embedded PowerPC 6xx/7xx/74xx/82xx/85xx support
-S: Austin, Texas 78729
-S: USA
-
 N: Jacques Gelinas
 E: jacques@solucorp.qc.ca
 D: Author of the Umsdos file system
@@ -1573,6 +1586,13 @@
 E: ajoshi@shell.unixbox.com
 D: fbdev hacking
 
+N: Jesper Juhl
+E: juhl-lkml@dif.dk
+D: Various small janitor fixes, cleanups etc.
+S: Lemnosvej 1, 3.tv
+S: 2300 Copenhagen S
+S: Denmark
+
 N: Bernhard Kaindl
 E: bkaindl@netway.at
 E: edv@bartelt.via.at
@@ -1824,11 +1844,6 @@
 S: 370 01  Ceske Budejovice
 S: Czech Republic
 
-N: Adam Belay
-E: ambx1@neo.rr.com
-D: Linux Plug and Play Support
-S: USA
-
 N: Bas Laarhoven
 E: sjml@xs4all.nl
 D: Loadable modules and ftape driver
@@ -1960,12 +1975,6 @@
 S: Niwot, Colorado 80503
 S: USA
 
-N: Pete Popov
-E: pete_popov@yahoo.com
-D: Linux/MIPS AMD/Alchemy Port and mips hacking and debugging
-S: San Jose, CA 95134
-S: USA
-
 N: Robert M. Love
 E: rml@tech9.net
 E: rml@novell.com
@@ -2587,6 +2596,12 @@
 D: sonypi, meye drivers, mct_u232 usb serial hacks
 S: Paris, France
 
+N: Pete Popov
+E: pete_popov@yahoo.com
+D: Linux/MIPS AMD/Alchemy Port and mips hacking and debugging
+S: San Jose, CA 95134
+S: USA
+
 N: Matt Porter
 E: mporter@kernel.crashing.org
 D: Motorola PowerPC PReP support
@@ -2826,7 +2841,6 @@
 S: Wellington
 S: New Zealand
 
-
 N: Sampo Saaristo
 E: sambo@cs.tut.fi
 D: Co-author of Multi-Protocol Over ATM (MPOA)
@@ -3297,14 +3311,6 @@
 S: 10200 Prague 10, Hostivar
 S: Czech Republic
 
-N: James R. Van Zandt
-E: jrv@vanzandt.mv.com
-P: 1024/E298966D F0 37 4F FD E5 7E C5 E6  F1 A0 1E 22 6F 46 DA 0C
-D: Author and maintainer of the Double Talk speech synthesizer driver
-S: 27 Spencer Drive
-S: Nashua, New Hampshire 03062
-S: USA
-
 N: Heikki Vatiainen
 E: hessu@cs.tut.fi
 D: Co-author of Multi-Protocol Over ATM (MPOA), some LANE hacks
@@ -3586,6 +3592,14 @@
 S: Tokyo 153
 S: Japan
 
+N: James R. Van Zandt
+E: jrv@vanzandt.mv.com
+P: 1024/E298966D F0 37 4F FD E5 7E C5 E6  F1 A0 1E 22 6F 46 DA 0C
+D: Author and maintainer of the Double Talk speech synthesizer driver
+S: 27 Spencer Drive
+S: Nashua, New Hampshire 03062
+S: USA
+
 N: Orest Zborowski
 E: orestz@eskimo.com
 D: XFree86 and kernel development
@@ -3627,13 +3641,6 @@
 D: EISA/sysfs subsystem
 S: France
 
-N: Luiz Fernando N. Capitulino
-E: lcapitulino@terra.com.br
-E: lcapitulino@prefeitura.sp.gov.br
-W: http://www.telecentros.sp.gov.br
-D: Little fixes and a lot of janitorial work
-S: E-GOV Telecentros SP
-S: Brazil
 
 # Don't add your name here, unless you really _are_ after Marc
 # alphabetically. Leonard used to be very proud of being the 


