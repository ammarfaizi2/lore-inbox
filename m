Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbUKVPSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbUKVPSl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbUKVPRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 10:17:15 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:62915 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262135AbUKVPPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:15:37 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041122714.9zlcKGKvXlpga8EP@topspin.com>
X-Mailer: roland_patchbomb
Date: Mon, 22 Nov 2004 07:14:17 -0800
Message-Id: <20041122714.taTI3zcdWo5JfuMd@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v1][10/12] Document InfiniBand ioctl use
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 15:14:22.0196 (UTC) FILETIME=[F2074340:01C4D0A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 0x1b ioctl magic number used by ib_umad module to
Documentation/ioctl-number.txt.

Signed-off-by: Roland Dreier <roland@topspin.com>


Index: linux-bk/Documentation/ioctl-number.txt
===================================================================
--- linux-bk.orig/Documentation/ioctl-number.txt	2004-11-21 21:07:31.047875266 -0800
+++ linux-bk/Documentation/ioctl-number.txt	2004-11-21 21:25:57.971600622 -0800
@@ -72,6 +72,7 @@
 0x09	all	linux/md.h
 0x12	all	linux/fs.h
 		linux/blkpg.h
+0x1b	all	InfiniBand Subsystem	<http://www.openib.org/>
 0x20	all	drivers/cdrom/cm206.h
 0x22	all	scsi/sg.h
 '#'	00-3F	IEEE 1394 Subsystem	Block for the entire subsystem

