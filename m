Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbUKXAJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUKXAJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUKWRdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:33:46 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:896 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261348AbUKWQRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:17:37 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041123816.bPLXoHbNS6amekEO@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:16:15 -0800
Message-Id: <20041123816.baaAyOggjbry3R4e@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][19/21] Document InfiniBand ioctl use
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:16:20.0834 (UTC) FILETIME=[C4EC2420:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 0x1b ioctl magic number used by ib_umad module to
Documentation/ioctl-number.txt.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/Documentation/ioctl-number.txt	2004-11-23 08:09:54.932309534 -0800
+++ linux-bk/Documentation/ioctl-number.txt	2004-11-23 08:10:24.016021218 -0800
@@ -72,6 +72,7 @@
 0x09	all	linux/md.h
 0x12	all	linux/fs.h
 		linux/blkpg.h
+0x1b	all	InfiniBand Subsystem	<http://www.openib.org/>
 0x20	all	drivers/cdrom/cm206.h
 0x22	all	scsi/sg.h
 '#'	00-3F	IEEE 1394 Subsystem	Block for the entire subsystem

