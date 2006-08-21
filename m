Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWHUXNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWHUXNu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWHUXNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:13:49 -0400
Received: from server6.greatnet.de ([83.133.96.26]:62177 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1751304AbWHUXNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:13:49 -0400
Message-ID: <44EA3E32.7060607@nachtwindheim.de>
Date: Tue, 22 Aug 2006 01:13:54 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [LIBATA] [mm] change path to libata in libata.tmpl
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Since libata moved from /drivers/scsi to /drivers/ata this template is broken.
This patch fixes it.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---

--- linux-2.6.18-rc4/Documentation/DocBook/libata.tmpl	2006-08-11 10:08:05.000000000 +0200
+++ linux-2.6.18-rc4-mm1/Documentation/DocBook/libata.tmpl	2006-08-18 17:13:10.000000000 +0200
@@ -868,18 +868,18 @@
 
   <chapter id="libataExt">
      <title>libata Library</title>
-!Edrivers/scsi/libata-core.c
+!Edrivers/ata/libata-core.c
   </chapter>
 
   <chapter id="libataInt">
      <title>libata Core Internals</title>
-!Idrivers/scsi/libata-core.c
+!Idrivers/ata/libata-core.c
   </chapter>
 
   <chapter id="libataScsiInt">
      <title>libata SCSI translation/emulation</title>
-!Edrivers/scsi/libata-scsi.c
-!Idrivers/scsi/libata-scsi.c
+!Edrivers/ata/libata-scsi.c
+!Idrivers/ata/libata-scsi.c
   </chapter>
 
   <chapter id="ataExceptions">
@@ -1600,12 +1600,12 @@
 
   <chapter id="PiixInt">
      <title>ata_piix Internals</title>
-!Idrivers/scsi/ata_piix.c
+!Idrivers/ata/ata_piix.c
   </chapter>
 
   <chapter id="SILInt">
      <title>sata_sil Internals</title>
-!Idrivers/scsi/sata_sil.c
+!Idrivers/ata/sata_sil.c
   </chapter>
 
   <chapter id="libataThanks">

