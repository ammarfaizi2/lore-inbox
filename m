Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbTABV0F>; Thu, 2 Jan 2003 16:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbTABV0F>; Thu, 2 Jan 2003 16:26:05 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:48068 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266564AbTABV0C>; Thu, 2 Jan 2003 16:26:02 -0500
From: Tomas Szepe <kala@pinerecords.com>
Date: Thu, 02 Jan 2003 22:34:28 +0100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [unify netdev config  2/22] arch-arm
Message-ID: <3E14B064.mailLQ511N346@louise.pinerecords.com>
User-Agent: nail 10.3 11/29/02
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig	2002-12-16 07:01:45.000000000 +0100
+++ b/arch/arm/Kconfig	2003-01-01 19:45:41.000000000 +0100
@@ -898,45 +898,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
-	depends on NET
-
-config NETDEVICES
-	bool "Network device support"
-	---help---
-	  You can say N here if you don't intend to connect your Linux box to
-	  any other computer at all or if all your connections will be over a
-	  telephone line with a modem either via UUCP (UUCP is a protocol to
-	  forward mail and news between unix hosts over telephone lines; read
-	  the UUCP-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>) or dialing up a shell
-	  account or a BBS, even using term (term is a program which gives you
-	  almost full Internet connectivity if you have a regular dial up
-	  shell account on some Internet connected Unix computer. Read
-	  <http://www.bart.nl/~patrickr/term-howto/Term-HOWTO.html>).
-
-	  You'll have to say Y if your computer contains a network card that
-	  you want to use under Linux (make sure you know its name because you
-	  will be asked for it and read the Ethernet-HOWTO (especially if you
-	  plan to use more than one network card under Linux)) or if you want
-	  to use SLIP (Serial Line Internet Protocol is the protocol used to
-	  send Internet traffic over telephone lines or null modem cables) or
-	  CSLIP (compressed SLIP) or PPP (Point to Point Protocol, a better
-	  and newer replacement for SLIP) or PLIP (Parallel Line Internet
-	  Protocol is mainly used to create a mini network by connecting the
-	  parallel ports of two local machines) or AX.25/KISS (protocol for
-	  sending Internet traffic over amateur radio links).
-
-	  Make sure to read the NET-3-HOWTO. Eventually, you will have to read
-	  Olaf Kirch's excellent and free book "Network Administrator's
-	  Guide", to be found in <http://www.linuxdoc.org/docs.html#guide>. If
-	  unsure, say Y.
-
-source "drivers/net/Kconfig"
-
-endmenu
-
 #   source net/ax25/Config.in
 source "net/irda/Kconfig"
 
