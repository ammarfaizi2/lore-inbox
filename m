Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbTABV3z>; Thu, 2 Jan 2003 16:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266627AbTABV25>; Thu, 2 Jan 2003 16:28:57 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:54980 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266584AbTABV1d>; Thu, 2 Jan 2003 16:27:33 -0500
From: Tomas Szepe <kala@pinerecords.com>
Date: Thu, 02 Jan 2003 22:35:59 +0100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [unify netdev config  8/22] arch-mips64
Message-ID: <3E14B0BF.mailLSI18A490@louise.pinerecords.com>
User-Agent: nail 10.3 11/29/02
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN a/arch/mips64/Kconfig b/arch/mips64/Kconfig
--- a/arch/mips64/Kconfig	2002-12-16 07:02:00.000000000 +0100
+++ b/arch/mips64/Kconfig	2003-01-01 19:50:47.000000000 +0100
@@ -504,47 +504,6 @@
 #source drivers/message/i2o/Config.in
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
-source "drivers/atm/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
