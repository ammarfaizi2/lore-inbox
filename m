Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265965AbUFTWRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265965AbUFTWRz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUFTWRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:17:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41941 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265965AbUFTWRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:17:44 -0400
Date: Mon, 21 Jun 2004 00:17:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: chas@cmf.nrl.navy.mil, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.4 patch] add ATM_FORE200E_USE_TASKLET Configure.help entry
Message-ID: <20040620221733.GC27822@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds the missing Configure.help entry for 
CONFIG_ATM_FORE200E_USE_TASKLET (text stolen from 2.6.7).

Please apply
Adrian

--- linux-2.4.27-rc1-full/Documentation/Configure.help.old	2004-06-21 00:01:56.000000000 +0200
+++ linux-2.4.27-rc1-full/Documentation/Configure.help	2004-06-21 00:09:09.000000000 +0200
@@ -7584,6 +7584,11 @@
   not have to supply an alternative one. They just say Y to "Use
   default SBA-200E firmware", above.
 
+CONFIG_ATM_FORE200E_USE_TASKLET
+  This defers work to be done by the interrupt handler to a
+  tasklet instead of handling everything at interrupt time.  This
+  may improve the responsiveness of the host.
+
 Maximum number of tx retries
 CONFIG_ATM_FORE200E_TX_RETRY
   Specifies the number of times the driver attempts to transmit
