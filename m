Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293433AbSBYQqX>; Mon, 25 Feb 2002 11:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293432AbSBYQqM>; Mon, 25 Feb 2002 11:46:12 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:42651 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S293425AbSBYQqA>; Mon, 25 Feb 2002 11:46:00 -0500
Message-Id: <200202251558.IAA20587@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Theodore Tso <tytso@mit.edu>
Subject: [PATCH] 2.5.5-dj1 add five help texts to drivers/char/Config.help
Date: Mon, 25 Feb 2002 09:44:18 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds help texts for CONFIG_SERIAL_TX3912, 
CONFIG_SERIAL_TX3912_CONSOLE, CONFIG_AU1000_SERIAL_CONSOLE,
CONFIG_AU1000_UART, CONFIG_EUROTECH_WDT to drivers/char/Config.help.

Steven

--- linux-2.5.5-dj1/drivers/char/Config.help.orig       Mon Feb 25 08:55:03 2002
+++ linux-2.5.5-dj1/drivers/char/Config.help    Mon Feb 25 09:30:35 2002
@@ -425,6 +425,24 @@
   read <file:Documentation/modules.txt>. The module will be called
   istallion.o.

+CONFIG_SERIAL_TX3912
+  The TX3912 is a Toshiba RISC processor based o the MIPS 3900 core;
+  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
+  Say Y here to enable kernel support for the on-board serial port.
+
+CONFIG_SERIAL_TX3912_CONSOLE
+  The TX3912 is a Toshiba RISC processor based o the MIPS 3900 core;
+  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
+  Say Y here to direct console I/O to the on-board serial port.
+
+CONFIG_AU1000_SERIAL_CONSOLE
+  If you have an Alchemy AU1000 processor (MIPS based) and you want
+  to use a console on a serial port, say Y.  Otherwise, say N.
+
+CONFIG_AU1000_UART
+  If you have an Alchemy AU1000 processor (MIPS based) and you want
+  to use serial ports, say Y.  Otherwise, say N.
+
 CONFIG_SYNCLINK
   Provides support for the SyncLink ISA and PCI multiprotocol serial
   adapters. These adapters support asynchronous and HDLC bit
@@ -942,6 +960,11 @@
   module, say M here and read <file:Documentation/modules.txt>.  Most
   people will say N.

+CONFIG_EUROTECH_WDT
+  Enable support for the watchdog timer on the Eurotech CPU-1220 and
+  CPU-1410 cards.  These are PC/104 SBCs. Spec sheets and product
+  information are at <http://www.eurotech.it/>.
+
 CONFIG_IB700_WDT
   This is the driver for the hardware watchdog on the IB700 Single
   Board Computer produced by TMC Technology (www.tmc-uk.com). This watchdog
