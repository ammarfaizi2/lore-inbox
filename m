Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWEKCJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWEKCJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 22:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWEKCJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 22:09:35 -0400
Received: from touchdown.wvpn.de ([212.227.64.97]:36292 "EHLO mail.wvpn.de")
	by vger.kernel.org with ESMTP id S1751228AbWEKCJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 22:09:34 -0400
Message-ID: <44629CF4.1070008@maintech.de>
Date: Thu, 11 May 2006 04:09:56 +0200
From: "Thomas Kleffel (maintech GmbH)" <tk@maintech.de>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060508)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ide_cs: Add IBM microdrive to known IDs
Content-Type: multipart/mixed;
 boundary="------------040704060002050107060301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040704060002050107060301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Thomas Kleffel <tk@maintech.de>

this patch adds the IBM microdrive to the known PCMCIA IDs for ide_cs.

Signed-off-by: Thomas Kleffel <tk@maintech.de>
---

This patch is against 2.6.17-rc3


--------------040704060002050107060301
Content-Type: text/x-patch;
 name="ide_cs.microdrive.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_cs.microdrive.patch"

diff -uprN l1/drivers/ide/legacy/ide-cs.c l2/drivers/ide/legacy/ide-cs.c
--- l1/drivers/ide/legacy/ide-cs.c	2006-05-11 00:19:59.000000000 +0200
+++ l2/drivers/ide/legacy/ide-cs.c	2006-05-11 03:38:03.000000000 +0200
@@ -392,6 +415,7 @@ static struct pcmcia_device_id ide_ids[]
 	PCMCIA_DEVICE_PROD_ID12("FREECOM", "PCCARD-IDE", 0x5714cbf7, 0x48e0ab8e),
 	PCMCIA_DEVICE_PROD_ID12("HITACHI", "FLASH", 0xf4f43949, 0x9eb86aae),
 	PCMCIA_DEVICE_PROD_ID12("HITACHI", "microdrive", 0xf4f43949, 0xa6d76178),
+	PCMCIA_DEVICE_PROD_ID12("IBM", "microdrive", 0xb569a6e5, 0xa6d76178),
 	PCMCIA_DEVICE_PROD_ID12("IBM", "IBM17JSSFP20", 0xb569a6e5, 0xf2508753),
 	PCMCIA_DEVICE_PROD_ID12("IO DATA", "CBIDE2      ", 0x547e66dc, 0x8671043b),
 	PCMCIA_DEVICE_PROD_ID12("IO DATA", "PCIDE", 0x547e66dc, 0x5c5ab149),

--------------040704060002050107060301--
