Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbUA3Txr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUA3Txq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:53:46 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18117 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265516AbUA3Tx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:53:29 -0500
Date: Fri, 30 Jan 2004 20:53:20 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] agpgart_be.c: remove dupliacte PCI_DEVICE_ID_SI_651 entry (fwd)
Message-ID: <20040130195319.GQ3004@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the trivial patch forwarded below still applies and compiles against 
2.4.25-pre8.

Please apply
Adrian


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Wed, 30 Jul 2003 23:39:54 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.4 patch] agpgart_be.c: remove dupliacte PCI_DEVICE_ID_SI_651 entry

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

