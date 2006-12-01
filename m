Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759116AbWLAOwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759116AbWLAOwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759120AbWLAOwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:52:39 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:60676 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759116AbWLAOwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:52:39 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] scsi aic7xxx parenthesis fix
Date: Fri, 1 Dec 2006 15:52:13 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011552.14234.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing parenthesis.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/scsi/aic7xxx/aic79xx_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/drivers/scsi/aic7xxx/aic79xx_pci.c	2005-04-04 03:42:19.000000000 +0200
+++ linux-2.4.34-pre6-b/drivers/scsi/aic7xxx/aic79xx_pci.c	2006-12-01 12:23:02.000000000 +0100
@@ -110,7 +110,7 @@ ahd_compose_id(u_int device, u_int vendo
 
 #define SUBID_9005_LEGACYCONN_FUNC(id) ((id) & 0x20)
 
-#define SUBID_9005_SEEPTYPE(id) ((id) & 0x0C0) >> 6)
+#define SUBID_9005_SEEPTYPE(id) (((id) & 0x0C0) >> 6)
 #define		SUBID_9005_SEEPTYPE_NONE	0x0
 #define		SUBID_9005_SEEPTYPE_4K		0x1
 


-- 
Regards,

	Mariusz Kozlowski
