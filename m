Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRDPPGf>; Mon, 16 Apr 2001 11:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129346AbRDPPGZ>; Mon, 16 Apr 2001 11:06:25 -0400
Received: from mail.scram.de ([195.226.127.117]:49856 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S129245AbRDPPGT>;
	Mon, 16 Apr 2001 11:06:19 -0400
Date: Mon, 16 Apr 2001 17:06:02 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
To: Steven Cole <elenstev@mesatop.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: List of recent (2.4.0 to 2.4.2-ac18) CONFIG options
 needing Configure.help text.
In-Reply-To: <01031023031904.08110@localhost.localdomain>
Message-ID: <Pine.NEB.4.33.0104161704370.20512-100000@www2.scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Sat, 10 Mar 2001, Steven Cole wrote:

> If you see any of _your_ options in the list below, please consider making
> a patch for Configure.help for your CONFIG option.

> CONFIG_TMSISA

--- Configure.help.old	Fri Feb 16 21:15:52 2001
+++ Configure.help	Mon Apr 16 17:03:39 2001
@@ -9730,6 +9730,18 @@
   The module will be called tmspci.o. If you want to compile it
   as a module, say M here and read Documentation/modules.txt.

+Generic TMS380 ISA support
+CONFIG_TMSISA
+  This tms380 module supports generic TMS380-based ISA cards.
+
+  These cards are known to work:
+     - SysKonnect TR4/16 ISA (SK-4190)
+
+  This driver is available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called tmsisa.o. If you want to compile it
+  as a module, say M here and read Documentation/modules.txt.
+
 Madge Smart 16/4 PCI Mk2 support
 CONFIG_ABYSS
   This tms380 module supports the Madge Smart 16/4 PCI Mk2

Cheers,
Jochen

