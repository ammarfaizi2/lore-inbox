Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbTIOO2T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbTIOO2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:28:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10979 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261407AbTIOO2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:28:17 -0400
Date: Mon, 15 Sep 2003 16:28:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.4 patch] add CONFIG_AGP_ATI Configure.help entry
Message-ID: <20030915142809.GG126@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below against 2.4.23-pre4 adds the missing Configure.help 
entry for CONFIG_AGP_ATI.

The help text is stolen from 2.6.

Please apply
Adrian

--- linux-2.4.23-pre4-full/Documentation/Configure.help.old	2003-09-15 16:25:06.000000000 +0200
+++ linux-2.4.23-pre4-full/Documentation/Configure.help	2003-09-15 16:26:02.000000000 +0200
@@ -4055,6 +4055,13 @@
   This option gives you AGP GART support for the HP ZX1 chipset
   for IA64 processors.
 
+CONFIG_AGP_ATI
+  This option gives you AGP support for the GLX component of
+  XFree86 4.x on the ATI RadeonIGP family of chipsets.
+
+  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
+  use GLX or DRI.  If unsure, say N.
+
 Support for ISA-bus hardware
 CONFIG_ISA
   Find out whether you have ISA slots on your motherboard.  ISA is the
