Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVDLFVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVDLFVC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVDLFTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:19:12 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:40024 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262012AbVDLDYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 23:24:50 -0400
Message-ID: <425B3F71.3030703@yahoo.com>
Date: Mon, 11 Apr 2005 20:24:33 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 4/6] Linux-iSCSI High-Performance Initiator
Content-Type: multipart/mixed;
 boundary="------------070708070109070405060106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070708070109070405060106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

              drivers/scsi/Makefile changes (added iscsi_if and iscsi_tcp).

              Signed-off-by: Alex Aizman <itn780@yahoo.com>
              Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>













--------------070708070109070405060106
Content-Type: text/plain;
 name="linux-iscsi-makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-iscsi-makefile.patch"

--- linux-2.6.12-rc2.orig/drivers/scsi/Makefile	2005-03-01 23:38:19.000000000 -0800
+++ linux-2.6.12-rc2.dima/drivers/scsi/Makefile	2005-04-11 18:13:12.000000000 -0700
@@ -30,6 +30,8 @@
 obj-$(CONFIG_SCSI_FC_ATTRS) 	+= scsi_transport_fc.o
 obj-$(CONFIG_SCSI_ISCSI_ATTRS)	+= scsi_transport_iscsi.o
 
+obj-$(CONFIG_ISCSI_IF)		+= iscsi_if.o
+obj-$(CONFIG_ISCSI_TCP) 	+= iscsi_tcp.o
 obj-$(CONFIG_SCSI_AMIGA7XX)	+= amiga7xx.o	53c7xx.o
 obj-$(CONFIG_A3000_SCSI)	+= a3000.o	wd33c93.o
 obj-$(CONFIG_A2091_SCSI)	+= a2091.o	wd33c93.o




--------------070708070109070405060106--
