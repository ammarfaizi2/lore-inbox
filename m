Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbUL1HmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUL1HmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 02:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbUL1HW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 02:22:29 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:49490 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262101AbUL1F7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:59:09 -0500
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       openib-general@openib.org
In-Reply-To: <200412272151.3Lde9MPbD7ODIUdu@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Mon, 27 Dec 2004 21:51:19 -0800
Message-Id: <200412272151.zeKZJPoIEBr55elh@topspin.com>
Mime-Version: 1.0
To: davem@davemloft.net
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v5][22/24] Document InfiniBand ioctl use
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 28 Dec 2004 05:51:19.0876 (UTC) FILETIME=[41115040:01C4ECA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 0x1b ioctl magic number used by ib_umad module to
Documentation/ioctl-number.txt.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/Documentation/ioctl-number.txt	2004-12-27 21:47:59.407053483 -0800
+++ linux-bk/Documentation/ioctl-number.txt	2004-12-27 21:48:28.036839302 -0800
@@ -72,6 +72,7 @@
 0x09	all	linux/md.h
 0x12	all	linux/fs.h
 		linux/blkpg.h
+0x1b	all	InfiniBand Subsystem	<http://www.openib.org/>
 0x20	all	drivers/cdrom/cm206.h
 0x22	all	scsi/sg.h
 '#'	00-3F	IEEE 1394 Subsystem	Block for the entire subsystem

