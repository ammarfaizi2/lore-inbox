Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTERTQq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 15:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbTERTQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 15:16:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:196 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262164AbTERTQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 15:16:44 -0400
Date: Sun, 18 May 2003 21:29:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [2.4 patch] add four CONFIG_HDLC_DEBUG_* Configure.help text
Message-ID: <20030518192933.GF12766@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
