Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbTE0XEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTE0XEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:04:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32756 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264424AbTE0XEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:04:47 -0400
Date: Wed, 28 May 2003 01:18:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] add four CONFIG_HDLC_DEBUG_* Configure.help text (fwd)
Message-ID: <20030527231759.GH19265@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the trivial Configure.help patch forwarded below still applies 
against 2.4.21-rc5.

Please include it in 2.4.21-rc6.

TIA
Adrian


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Sun, 18 May 2003 21:29:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org,
    linux-net@vger.kernel.org
Subject: [2.4 patch] add four CONFIG_HDLC_DEBUG_* Configure.help text

Hi Marcelo,

the patch below adds four Configure.help entries that were missing in 
2.4.21-rc2 (I've taken the texts from 2.5).

Please apply
Adrian


--- linux-2.4.21-rc2/Documentation/Configure.help.old	2003-05-18 21:21:51.000000000 +0200
+++ linux-2.4.21-rc2/Documentation/Configure.help	2003-05-18 21:23:46.000000000 +0200
@@ -9684,6 +9684,26 @@
   should add "alias syncX farsync" to /etc/modules.conf for each
   interface, where X is 0, 1, 2, ...
 
+CONFIG_HDLC_DEBUG_PKT
+  This option is for developers only - do NOT use on production
+  systems.
+
+CONFIG_HDLC_DEBUG_HARD_HEADER
+  This option is for developers only - do NOT use on production
+  systems.
+
+CONFIG_HDLC_DEBUG_ECN
+  This option is for developers only - do NOT use on production
+  systems.
+
+CONFIG_HDLC_DEBUG_RINGS
+  If you answer Y here you will be able to get a diagnostic dump of
+  port's TX and RX packet rings, using "sethdlc hdlcX private"
+  command. It does not affect normal operations.
+
+  If unsure, say Y here.
+
+
 Frame Relay (DLCI) support
 CONFIG_DLCI
   This is support for the frame relay protocol; frame relay is a fast
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

