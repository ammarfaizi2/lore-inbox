Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbULMT2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbULMT2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbULMT2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:28:05 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:49464 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262252AbULMSLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:11:15 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041213109.dhdvNgaA6X6YHRdV@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Mon, 13 Dec 2004 10:09:59 -0800
Message-Id: <20041213109.42OdQqmmAkW2Pv7s@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v3][19/21] Document InfiniBand ioctl use
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 13 Dec 2004 18:10:04.0990 (UTC) FILETIME=[F8B2B5E0:01C4E13E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 0x1b ioctl magic number used by ib_umad module to
Documentation/ioctl-number.txt.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/Documentation/ioctl-number.txt	2004-12-11 15:16:34.000000000 -0800
+++ linux-bk/Documentation/ioctl-number.txt	2004-12-13 09:44:50.671260584 -0800
@@ -72,6 +72,7 @@
 0x09	all	linux/md.h
 0x12	all	linux/fs.h
 		linux/blkpg.h
+0x1b	all	InfiniBand Subsystem	<http://www.openib.org/>
 0x20	all	drivers/cdrom/cm206.h
 0x22	all	scsi/sg.h
 '#'	00-3F	IEEE 1394 Subsystem	Block for the entire subsystem

