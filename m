Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTKLUte (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 15:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTKLUte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 15:49:34 -0500
Received: from ee.oulu.fi ([130.231.61.23]:15558 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S261539AbTKLUtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 15:49:33 -0500
Date: Wed, 12 Nov 2003 22:46:49 +0200
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] add Promise 20376 PCI ID
Message-ID: <20031112204649.GA9290@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this adds the Promise SATA controller ID that is used on my Asus A7V8X,
which seems to work perfectly after adding the patch.

--- linux-2.6.0-test9/drivers/scsi/sata_promise.c~	2003-11-12 18:02:44.000000000 +0200
+++ linux-2.6.0-test9/drivers/scsi/sata_promise.c	2003-11-12 18:02:44.000000000 +0200
@@ -213,6 +213,8 @@
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,

