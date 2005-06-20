Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVFTUPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVFTUPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFTUPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:15:45 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:23966 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261537AbVFTUOY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:14:24 -0400
Subject: PATCH: Samsung SN-124 works perfectly well with DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119298324.3304.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Jun 2005 21:12:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Been in Red Hat products for ages

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12/drivers/ide/ide-dma.c linux-2.6.12/drivers/ide/ide-dma.c
--- linux.vanilla-2.6.12/drivers/ide/ide-dma.c	2005-06-19 11:30:47.000000000 +0100
+++ linux-2.6.12/drivers/ide/ide-dma.c	2005-06-20 20:43:16.000000000 +0100
@@ -132,7 +132,6 @@
 	{ "SAMSUNG CD-ROM SC-148C",	"ALL"		},
 	{ "SAMSUNG CD-ROM SC",	"ALL"		},
 	{ "SanDisk SDP3B-64"	,	"ALL"		},
-	{ "SAMSUNG CD-ROM SN-124",	"ALL"		},
 	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	"ALL"		},
 	{ "_NEC DV5800A",               "ALL"           },  
 	{ NULL			,	NULL		}

