Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265961AbUFTWIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUFTWIR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUFTWIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:08:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32726 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265961AbUFTWIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:08:06 -0400
Date: Mon, 21 Jun 2004 00:07:52 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: chas@cmf.nrl.navy.mil
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix typos in ATM_FORE200E_USE_TASKLET help text
Message-ID: <20040620220752.GB27822@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial patch below fixes two typos in the ATM_FORE200E_USE_TASKLET 
help text.

Please apply
Adrian

--- linux-2.6.7/drivers/atm/Kconfig.old	2004-06-21 00:03:30.000000000 +0200
+++ linux-2.6.7/drivers/atm/Kconfig	2004-06-21 00:07:29.000000000 +0200
@@ -391,8 +391,8 @@
 	default n
 	help
 	  This defers work to be done by the interrupt handler to a
-	  tasklet instead of hanlding everything at interrupt time.  This
-	  may improve the responsive of the host.
+	  tasklet instead of handling everything at interrupt time.  This
+	  may improve the responsiveness of the host.
 
 config ATM_FORE200E_TX_RETRY
 	int "Maximum number of tx retries"
