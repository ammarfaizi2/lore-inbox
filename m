Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbTFTXvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 19:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbTFTXvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 19:51:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6139 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265038AbTFTXvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 19:51:51 -0400
Date: Sat, 21 Jun 2003 02:05:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, andrew.grover@intel.com
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       trivial@rustcorp.com.au
Subject: [2.4 patch] add three ACPI Configure.help entries
Message-ID: <20030621000550.GP29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds Configure.help entries for three ACPI options added 
in 2.4.22-pre1 (help texts stolen from 2.5).

Please apply
Adrian


--- linux-2.4.22-pre1-full/Documentation/Configure.help.old	2003-06-21 01:51:34.000000000 +0200
+++ linux-2.4.22-pre1-full/Documentation/Configure.help	2003-06-21 02:00:54.000000000 +0200
@@ -18691,6 +18691,20 @@
   down the system.  Until then, you can cat it, and see output when
   a button is pressed.
 
+CONFIG_ACPI_BATTERY
+  This driver adds support for battery information through
+  /proc/acpi/battery. If you have a mobile system with a battery, 
+  say Y.
+
+CONFIG_ACPI_FAN
+  This driver adds support for ACPI fan devices, allowing user-mode 
+  applications to perform basic fan control (on, off, status).
+
+CONFIG_ACPI_PROCESSOR
+  This driver installs ACPI as the idle handler for Linux, and uses
+  ACPI C2 and C3 processor states to save power, on systems that
+  support it.
+
 ACPI AC Adapter
 CONFIG_ACPI_AC
   This driver adds support for the AC Adapter object, which indicates
