Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267383AbUHMTrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267383AbUHMTrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267351AbUHMTnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:43:14 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:26612 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S267334AbUHMTjm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:39:42 -0400
Message-ID: <411D18CA.9060709@ttnet.net.tr>
Date: Fri, 13 Aug 2004 22:38:50 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4] amd76xrom.c unused warning
Content-Type: multipart/mixed;
	boundary="------------040003060109030103050300"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040003060109030103050300
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

$SUBJECT

--------------040003060109030103050300
Content-Type: text/plain;
	name="amd76xrom.c-unused.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="amd76xrom.c-unused.diff"

--- 27rc5~/drivers/mtd/maps/amd76xrom.c	2003-06-13 17:51:34.000000000 +0300
+++ 27rc5/drivers/mtd/maps/amd76xrom.c	2004-08-07 14:09:39.000000000 +0300
@@ -178,7 +178,7 @@
 	iounmap((void *)(info->window_addr));
 err_out_free_mmio_region:
 	release_mem_region(window->start, window->size);
-err_out_none:
+//err_out_none:
 	return -ENODEV;
 }
 

--------------040003060109030103050300--
