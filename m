Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317323AbSFCJHB>; Mon, 3 Jun 2002 05:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317325AbSFCJHA>; Mon, 3 Jun 2002 05:07:00 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:42473 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317323AbSFCJHA>; Mon, 3 Jun 2002 05:07:00 -0400
Subject: agppart SiS 745 Patch
From: Carsten Rietzschel <cr@daRav.de>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-CWj9Kerl7jIaWgvLXP+6"
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Jun 2002 11:06:20 +0200
Message-Id: <1023095181.1519.15.camel@rav-pc-linux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CWj9Kerl7jIaWgvLXP+6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

only added support SiS 745-IDs to PCI-Device list.

So agp-try-unsupported kernel option will not be nessecary
for let this chipset work.

This patch is against 2.5.20 
(but the same changes will also work for 2.4-kernel series).


Carsten Rietzschel




--=-CWj9Kerl7jIaWgvLXP+6
Content-Description: 
Content-Disposition: inline; filename=agppart-sis735-patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15

--- linux-2.5.20/drivers/char/agp/agpgart_be.c	Mon Jun  3 10:43:45 2002
+++ linux-2.5.20/drivers/char/agp/agpgart_be.c.org	Mon Jun  3 03:44:42 2002
@@ -4562,12 +4562,6 @@
 		"SiS",
 		"735",
 		sis_generic_setup },
-	{ PCI_DEVICE_ID_SI_745,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"745",
-		sis_generic_setup },
 	{ PCI_DEVICE_ID_SI_730,
 		PCI_VENDOR_ID_SI,
 		SIS_GENERIC,

--=-CWj9Kerl7jIaWgvLXP+6--

