Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933633AbWKQVEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933633AbWKQVEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755917AbWKQVBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:01:47 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:42170 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755901AbWKQVBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:40 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 06/15] sas_ata: Require CONFIG_ATA in Kconfig
Date: Fri, 17 Nov 2006 13:07:59 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210759.17052.27132.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/libsas/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/libsas/Kconfig b/drivers/scsi/libsas/Kconfig
index aafdc92..b64e391 100644
--- a/drivers/scsi/libsas/Kconfig
+++ b/drivers/scsi/libsas/Kconfig
@@ -24,7 +24,7 @@ #
 
 config SCSI_SAS_LIBSAS
 	tristate "SAS Domain Transport Attributes"
-	depends on SCSI
+	depends on SCSI && ATA
 	select SCSI_SAS_ATTRS
 	help
 	  This provides transport specific helpers for SAS drivers which
