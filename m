Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUFTWeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUFTWeW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUFTWeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:34:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38868 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265973AbUFTWeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:34:18 -0400
Date: Mon, 21 Jun 2004 00:34:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: cramerj@intel.com, john.ronciak@intel.com, Ganesh.Venkatesan@intel.com,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: [2.4 patch] add missing E1000_NAPI Configure.help text
Message-ID: <20040620223409.GD27822@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds the missing Configure.help text for 
CONFIG_E1000_NAPI.

The text is the same Jeff accepted for 2.6.

Please apply
Adrian

--- linux-2.4.27-rc1-full/Documentation/Configure.help.old	2004-06-21 00:01:56.000000000 +0200
+++ linux-2.4.27-rc1-full/Documentation/Configure.help	2004-06-21 00:29:17.000000000 +0200
@@ -12164,6 +12164,20 @@
   module, say M here and read <file:Documentation/modules.txt> as well
   as <file:Documentation/networking/net-modules.txt>.
 
+CONFIG_E1000_NAPI
+  NAPI is a new driver API designed to reduce CPU and interrupt load
+  when the driver is receiving lots of packets from the card. It is
+  still somewhat experimental and thus not yet enabled by default.
+
+  If your estimated Rx load is 10kpps or more, or if the card will be
+  deployed on potentially unfriendly networks (e.g. in a firewall),
+  then say Y here.
+
+  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+  information.
+
+  If in doubt, say N.
+
 AMD LANCE and PCnet (AT1500 and NE2100) support
 CONFIG_LANCE
   If you have a network (Ethernet) card of this type, say Y and read
