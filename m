Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTH2M5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 08:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTH2M5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 08:57:12 -0400
Received: from sv11.nswasp.com ([211.123.197.122]:27405 "EHLO jpnrel2.hp.com")
	by vger.kernel.org with ESMTP id S261159AbTH2M5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 08:57:09 -0400
Message-ID: <66A8482545B4C0419D82AF923264AFB0085E4B6A@xjp02.jpn.hp.com>
From: "IIDA,MASANARI (HP-Japan,ex2)" <masanari.iida@hp.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'marcelo@conectiva.com.br'" <marcelo@conectiva.com.br>
Subject: [patch] scsi_scan.c missing entry for HP Va7140 
Date: Fri, 29 Aug 2003 21:57:05 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo

This is a patch for HP Disk Array Va7110 and Va7140.
As Stefan Schindewolf reported on 25/Aug 2003 on Kernel mailing list,
scsi_scan.c has missing entory and also typo.
Apply this patch on 2.4.23-preX.

Regards,

masanari 

--- linux-2.4.22/drivers/scsi/scsi_scan.c	Mon Aug 25 20:44:42 2003
+++ linux-2.4.22-fix/drivers/scsi/scsi_scan.c	Tue Aug 26 17:28:41 2003
@@ -114,7 +114,8 @@
 	{"HP", "C2500A", "", BLIST_NOLUN},			/* scanjet
iicx */
 	{"HP", "A6188A", "*", BLIST_SPARSELUN | BLIST_LARGELUN},/* HP Va7100
Array */
 	{"HP", "A6189A", "*", BLIST_SPARSELUN | BLIST_LARGELUN},/* HP Va7400
Array */
-	{"HP", "A6189B", "*", BLIST_SPARSELUN | BLIST_LARGELUN},/* HP Va7410
Array */
+	{"HP", "A6189B", "*", BLIST_SPARSELUN | BLIST_LARGELUN},/* HP Va7110
Array */
+	{"HP", "A6218A", "*", BLIST_SPARSELUN | BLIST_LARGELUN},/* HP Va7410
Array */
 	{"YAMAHA", "CDR100", "1.00", BLIST_NOLUN},		/* Locks up
if polled for lun != 0 */
 	{"YAMAHA", "CDR102", "1.00", BLIST_NOLUN},		/* Locks up
if polled for lun != 0  
 								 * extra
reset */
