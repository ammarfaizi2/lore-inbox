Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313996AbSDQA52>; Tue, 16 Apr 2002 20:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313993AbSDQAzz>; Tue, 16 Apr 2002 20:55:55 -0400
Received: from mail.mesatop.com ([208.164.122.9]:1285 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S313992AbSDQAzt>;
	Tue, 16 Apr 2002 20:55:49 -0400
Subject: [PATCH] 2.5.8-dj1, add four help texts to
	drivers/net/wan/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1019004735.16110.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution/1.0.2-5mdk 
Date: 16 Apr 2002 18:54:21 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds four help texts to drivers/net/wan/Config.help.
The texts were obtained from the 2.4.19-pre7 Configure.help.

Steven

--- linux-2.5.8-dj1/drivers/net/wan/Config.help.orig	Tue Apr 16 13:24:27 2002
+++ linux-2.5.8-dj1/drivers/net/wan/Config.help	Tue Apr 16 13:28:26 2002
@@ -398,6 +398,37 @@
 
   If unsure, say N here.
 
+CONFIG_COMX_HW_MUNICH
+  Hardware driver for the 'SliceCOM' (channelized E1) and 'PciCOM'
+  boards (X21) from the MultiGate family.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called comx-hw-munich.o. If you want to compile it
+  as a module, say M here and read Documentation/modules.txt.
+
+  Read linux/Documentation/networking/slicecom.txt for help on
+  configuring and using SliceCOM interfaces. Further info on these cards
+  can be found at http://www.itc.hu or <info@itc.hu>.
+
+CONFIG_HDLC_RAW
+  Say Y to this option if you want generic HDLC driver to support
+  raw HDLC over WAN (Wide Area Network) connections.
+
+  If unsure, say N here.
+
+CONFIG_HDLC_CISCO
+  Say Y to this option if you want generic HDLC driver to support
+  Cisco HDLC over WAN (Wide Area Network) connections.
+
+  If unsure, say N here.
+
+CONFIG_HDLC_FR
+  Say Y to this option if you want generic HDLC driver to support
+  Frame-Relay protocol over WAN (Wide Area Network) connections.
+
+  If unsure, say N here.
+
 CONFIG_HDLC_PPP
   Say Y to this option if you want generic HDLC driver to support
   PPP over WAN (Wide Area Network) connections.



