Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268847AbUHLWnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268847AbUHLWnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268850AbUHLWms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:42:48 -0400
Received: from apollo.tuxdriver.com ([24.172.12.4]:53777 "EHLO
	ra.tuxdriver.com") by vger.kernel.org with ESMTP id S268847AbUHLWk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:40:58 -0400
Date: Thu, 12 Aug 2004 17:37:29 -0400
From: "John W. Linville" <linville@tuxdriver.com>
Message-Id: <200408122137.i7CLbTa13693@ra.tuxdriver.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4 -- add IOI Media Bay to SCSI quirk list
Cc: linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urNp linux-2.4.orig/drivers/scsi/scsi_scan.c linux-2.4/drivers/scsi/scsi_scan.c
--- linux-2.4.orig/drivers/scsi/scsi_scan.c	2004-08-12 18:31:17.592759000 -0400
+++ linux-2.4/drivers/scsi/scsi_scan.c	2004-08-12 18:33:35.847741768 -0400
@@ -189,6 +189,7 @@ static struct dev_info device_list[] =
 	{"HITACHI", "DF500", "*", BLIST_SPARSELUN},
 	{"HITACHI", "DF600", "*", BLIST_SPARSELUN},
 	{"IBM", "ProFibre 4000R", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
+	{"IOI", "Media Bay", "*", BLIST_FORCELUN},
 	{"HITACHI", "OPEN-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},  /* HITACHI XP Arrays */
 	{"HITACHI", "DISK-SUBSYSTEM", "*", BLIST_SPARSELUN | BLIST_LARGELUN},  /* HITACHI 9960 */
 	{"WINSYS","FLASHDISK G6", "*", BLIST_SPARSELUN},
