Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268067AbUHQB3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268067AbUHQB3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 21:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268066AbUHQB3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 21:29:30 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62975 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268067AbUHQB2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 21:28:48 -0400
Date: Tue, 17 Aug 2004 03:28:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: [patch] 2.4.28-pre1: add two SATA Configure.help entries
Message-ID: <20040817012845.GM1387@fs.tum.de>
References: <20040815213229.GA11500@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815213229.GA11500@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The trivial patch below adds the missing Configure.help entries for two 
new options.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.4.28-pre1-full/Documentation/Configure.help.old	2004-08-17 03:14:48.000000000 +0200
+++ linux-2.4.28-pre1-full/Documentation/Configure.help	2004-08-17 03:21:35.000000000 +0200
@@ -9299,6 +9299,16 @@
 
   If unsure, say N.
 
+CONFIG_SCSI_ATA_PIIX
+  This option enables support for ICH5 Serial ATA.
+
+  If unsure, say N.
+
+CONFIG_SCSI_SATA_NV
+  This option enables support for NVIDIA Serial ATA.
+
+  If unsure, say N.
+
 CONFIG_SCSI_SATA_PROMISE
   This option enables support for Promise Serial ATA TX2/TX4.
 

