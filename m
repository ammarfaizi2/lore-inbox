Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbULNEPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbULNEPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbULNEOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:14:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32265 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261403AbULNEKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 23:10:07 -0500
Date: Tue, 14 Dec 2004 05:10:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linuxraid@amcc.com
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] 3w-abcd.h: TW_Device_Extension: remove an unused filed
Message-ID: <20041214041002.GX23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ subject adapted to linux-kernel filters... ]

num_units in struct TAG_TW_Device_Extension is completely unused.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/drivers/scsi/3w-xxxx.h.old	2004-12-14 04:39:15.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/scsi/3w-xxxx.h	2004-12-14 04:39:20.000000000 +0100
@@ -397,7 +397,6 @@
 	unsigned long		*alignment_virtual_address[TW_Q_LENGTH];
 	unsigned long		alignment_physical_address[TW_Q_LENGTH];
 	int			is_unit_present[TW_MAX_UNITS];
-	int			num_units;
 	unsigned long		*command_packet_virtual_address[TW_Q_LENGTH];
 	unsigned long		command_packet_physical_address[TW_Q_LENGTH];
 	struct pci_dev		*tw_pci_dev;

