Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319325AbSH2Tlt>; Thu, 29 Aug 2002 15:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319326AbSH2Tlt>; Thu, 29 Aug 2002 15:41:49 -0400
Received: from www.microgate.com ([216.30.46.105]:42759 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S319325AbSH2Tls>; Thu, 29 Aug 2002 15:41:48 -0400
Subject: [PATCH] Configure.help (synclinkmp/_cs)
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 29 Aug 2002 14:46:16 -0500
Message-Id: <1030650376.961.2.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch contains the help sections for
the SyncLink MP/CS drivers added to 2.4.20-pre5.

--- linux-2.4.20-pre5/Documentation/Configure.help	Thu Aug 29 13:32:18 2002
+++ linux-2.4.20-pre5-mg/Documentation/Configure.help	Thu Aug 29 14:40:19 2002
@@ -3411,6 +3411,16 @@
   a module, say M here and read <file:Documentation/modules.txt>.
   If unsure, say N.
 
+CONFIG_SYNCLINK_CS
+  Enable support for the SyncLink PC Card serial adapter, running
+  asynchronous and HDLC communications up to 512Kbps. The port is
+  selectable for RS-232, V.35, RS-449, RS-530, and X.21
+
+  This driver may be built as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called synclink_cs.o.  If you want to do that, say M
+  here.
+
 ACP Modem (Mwave) support
 CONFIG_MWAVE
   The ACP modem (Mwave) for Linux is a WinModem. It is composed of a
@@ -16874,6 +16884,17 @@
   This driver can only be built as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
   The module will be called synclink.o.  If you want to do that, say M
+  here.
+
+CONFIG_SYNCLINKMP
+  Enable support for the SyncLink Multiport (2 or 4 ports)
+  serial adapter, running asynchronous and HDLC communications up
+  to 2.048Mbps. Each ports is independently selectable for
+  RS-232, V.35, RS-449, RS-530, and X.21
+
+  This driver may be built as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called synclinkmp.o.  If you want to do that, say M
   here.
 
 Synchronous HDLC line discipline support


