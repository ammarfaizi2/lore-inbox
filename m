Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbULMQBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbULMQBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbULMQBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:01:17 -0500
Received: from smtp.infolink.com.br ([200.187.64.6]:63242 "EHLO
	smtp.infolink.com.br") by vger.kernel.org with ESMTP
	id S261252AbULMQBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:01:08 -0500
Subject: [PATCH] sata_sil.c: blacklist seagate ST3200822AS
From: Haroldo Gamal <haroldo.gamal@infolink.com.br>
Reply-To: haroldo.gamal@infolink.com.br
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-msS7KLK/FV8AJgjm45S/"
Organization: Infolink LTDA
Message-Id: <1102953668.15647.30.camel@gamal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Dec 2004 14:01:09 -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-msS7KLK/FV8AJgjm45S/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Jeff,

Here is the patch to add the seagate ST3200822AS to the "sata_sil.c"
blacklist.

Thank you in advance,

-- 
Haroldo Gamal
Departamento Técnico
haroldo.gamal@infolink.com.br
http://www.infolink.com.br

--=-msS7KLK/FV8AJgjm45S/
Content-Disposition: attachment; filename=sata_sil.patch
Content-Type: text/x-patch; name=sata_sil.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.9-1.6_FC2/drivers/scsi/sata_sil.c linux-2.6.9-1.6_FC2.hg/drivers/scsi/sata_sil.c
--- linux-2.6.9-1.6_FC2/drivers/scsi/sata_sil.c	2004-11-19 01:00:46.000000000 -0200
+++ linux-2.6.9-1.6_FC2.hg/drivers/scsi/sata_sil.c	2004-12-13 13:45:44.000000000 -0200
@@ -88,6 +88,7 @@
 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3120026AS",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3200822AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },

--=-msS7KLK/FV8AJgjm45S/--

