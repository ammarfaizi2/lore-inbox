Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVCGH1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVCGH1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 02:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVCGHXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 02:23:52 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:40880 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261670AbVCGHQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 02:16:26 -0500
Message-ID: <422BFFAC.6090509@yahoo.com>
Date: Sun, 06 Mar 2005 23:15:56 -0800
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 4/6] Open-iSCSI High-Performance Initiator for Linux
Content-Type: multipart/mixed;
 boundary="------------050606000201070809070804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050606000201070809070804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

          drivers/scsi/Makefile changes.

          Signed-off-by: Alex Aizman <itn780@yahoo.com>
          Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>









--------------050606000201070809070804
Content-Type: text/plain;
 name="open-iscsi-makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="open-iscsi-makefile.patch"

--- linux-2.6.11.orig/drivers/scsi/Makefile	2005-03-01 23:38:19.000000000 -0800
+++ linux-2.6.11.dima/drivers/scsi/Makefile	2005-03-04 17:50:11.142413217 -0800
@@ -30,6 +30,8 @@
 obj-$(CONFIG_SCSI_FC_ATTRS) 	+= scsi_transport_fc.o
 obj-$(CONFIG_SCSI_ISCSI_ATTRS)	+= scsi_transport_iscsi.o
 
+obj-$(CONFIG_ISCSI_IF)		+= iscsi_if.o
+obj-$(CONFIG_ISCSI_TCP) 	+= iscsi_tcp.o
 obj-$(CONFIG_SCSI_AMIGA7XX)	+= amiga7xx.o	53c7xx.o
 obj-$(CONFIG_A3000_SCSI)	+= a3000.o	wd33c93.o
 obj-$(CONFIG_A2091_SCSI)	+= a2091.o	wd33c93.o










--------------050606000201070809070804--
