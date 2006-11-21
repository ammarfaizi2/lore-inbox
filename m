Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030608AbWKUAsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030608AbWKUAsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030596AbWKUAsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:48:12 -0500
Received: from mail0.lsil.com ([147.145.40.20]:25276 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1030592AbWKUAsK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:48:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] drivers/scsi/megaraid/megaraid_sas.c: make 2 functions static
Date: Mon, 20 Nov 2006 17:40:32 -0700
Message-ID: <0631C836DBF79F42B5A60C8C8D4E82297F81D5@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/scsi/megaraid/megaraid_sas.c: make 2 functions static
Thread-Index: AccMSu7hjupeWtmwSBe9BU525HkwUQAuqTQg
From: "Patro, Sumant" <Sumant.Patro@lsi.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Kolli, Neela" <Neela.Kolli@lsi.com>, <James.Bottomley@SteelEye.com>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Nov 2006 00:40:34.0740 (UTC) FILETIME=[A7F81740:01C70D05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack.
Thanks for submitting the patch.

Regards,

Sumant 

-----Original Message-----
From: Adrian Bunk [mailto:bunk@stusta.de] 
Sent: Sunday, November 19, 2006 6:24 PM
To: Patro, Sumant
Cc: Kolli, Neela; James.Bottomley@SteelEye.com;
linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/megaraid/megaraid_sas.c: make 2
functions static

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/megaraid/megaraid_sas.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19-rc5-mm2/drivers/scsi/megaraid/megaraid_sas.c.old
2006-11-20 00:55:39.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/scsi/megaraid/megaraid_sas.c
2006-11-20 00:55:57.000000000 +0100
@@ -517,7 +517,7 @@
  * Returns the number of frames required for numnber of sge's
(sge_count)
  */
 
-u32 megasas_get_frame_count(u8 sge_count)
+static u32 megasas_get_frame_count(u8 sge_count)
 {
 	int num_cnt;
 	int sge_bytes;
@@ -1733,7 +1733,7 @@
  *
  * Tasklet to complete cmds
  */
-void megasas_complete_cmd_dpc(unsigned long instance_addr)
+static void megasas_complete_cmd_dpc(unsigned long instance_addr)
 {
 	u32 producer;
 	u32 consumer;

