Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272273AbTG3VkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272275AbTG3VkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:40:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62197 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S272273AbTG3VkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:40:05 -0400
Date: Wed, 30 Jul 2003 23:39:54 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.4 patch] agpgart_be.c: remove dupliacte PCI_DEVICE_ID_SI_651 entry
Message-ID: <20030730213954.GB22991@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

agpgart_be.c contains two entries for PCI_DEVICE_ID_SI_651. The patch 
below removes one of them.

I've tested the compilation eith 2.4.22-pre9.

cu
Adrian

--- linux-2.4.22-pre9-full/drivers/char/agp/agpgart_be.c.old	2003-07-30 23:34:54.000000000 +0200
+++ linux-2.4.22-pre9-full/drivers/char/agp/agpgart_be.c	2003-07-30 23:35:43.000000000 +0200
@@ -4961,30 +4961,24 @@
 	{ PCI_DEVICE_ID_SI_651,
 		PCI_VENDOR_ID_SI,
 		SIS_GENERIC,
 		"SiS",
 		"651",
 		sis_generic_setup },
 	{ PCI_DEVICE_ID_SI_650,
 		PCI_VENDOR_ID_SI,
 		SIS_GENERIC,
 		"SiS",
 		"650",
 		sis_generic_setup },
-	{ PCI_DEVICE_ID_SI_651,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"651",
-		sis_generic_setup },
 	{ PCI_DEVICE_ID_SI_645,
 		PCI_VENDOR_ID_SI,
 		SIS_GENERIC,
 		"SiS",
 		"645",
 		sis_generic_setup },
 	{ PCI_DEVICE_ID_SI_646,
 		PCI_VENDOR_ID_SI,
 		SIS_GENERIC,
 		"SiS",
 		"646",
 		sis_generic_setup },
