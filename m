Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271647AbTGRARQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 20:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271649AbTGRARQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 20:17:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:63434 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271647AbTGRARO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 20:17:14 -0400
Date: Fri, 18 Jul 2003 02:32:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, bcollins@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] add a Conigure.help entry for CONFIG_IEEE1394_OUI_DB
Message-ID: <20030718003207.GW1407@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial patch below add a Configure.help entry for 
CONFIG_IEEE1394_OUI_DB to 2.4.22-pre6. The text is stolen from 
2.6.0-test1.

Please apply
Adrian


--- linux-2.4.22-pre6-full/Documentation/Configure.help.old	2003-07-18 02:26:46.000000000 +0200
+++ linux-2.4.22-pre6-full/Documentation/Configure.help	2003-07-18 02:28:52.000000000 +0200
@@ -8822,6 +8822,17 @@
   Say Y if you really want or need the debugging output, everyone else
   says N.
 
+CONFIG_IEEE1394_OUI_DB
+  If you say Y here, then an OUI list (vendor unique ID's) will be
+  compiled into the ieee1394 module. This doesn't really do much
+  accept being able to display the vendor of a hardware node. The
+  downside is that it adds about 300k to the size of the module,
+  or kernel (depending on whether you compile ieee1394 as a
+  module, or static in the kernel).
+
+  This option is not needed for userspace programs like gscanbus
+  to show this information.
+
 Network device support
 CONFIG_NETDEVICES
   You can say N here if you don't intend to connect your Linux box to
