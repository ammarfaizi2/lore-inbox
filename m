Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318133AbSIJVEn>; Tue, 10 Sep 2002 17:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318136AbSIJVEn>; Tue, 10 Sep 2002 17:04:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3317 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318133AbSIJVEl>; Tue, 10 Sep 2002 17:04:41 -0400
Date: Tue, 10 Sep 2002 23:09:22 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "Martin K. Petersen" <mkp@mkp.net>
cc: linux-kernel@vger.kernel.org
Subject: [patch] Configure.help entry for the ForteMedia FM801 driver
Message-ID: <Pine.NEB.4.44.0209102306151.18902-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

2.4.20-pre6 adds the ForteMedia FM801 driver but there's no Configure.help
entry. I found the entry below at the homepage of Martin K. Petersen, the
author of this driver.

cu
Adrian


--- Documentation/Configure.help.old	2002-09-10 22:38:42.000000000 +0200
+++ Documentation/Configure.help	2002-09-10 23:04:06.000000000 +0200
@@ -19810,6 +19812,12 @@
   Say Y or M if you have a sound system driven by ESS's Maestro 3
   PCI sound chip.

+ForteMedia FM801 driver
+CONFIG_SOUND_FORTE
+  Say Y or M if you want driver support for the ForteMedia FM801 PCI
+  audio controller (Abit AU10, Genius Sound Maker, HP Workstation
+  zx2000, and others).
+
 Adlib Cards
 CONFIG_SOUND_ADLIB
   Includes ASB 64 4D. Information on programming AdLib cards is


