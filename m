Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbULTHmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbULTHmQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbULTHmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:42:16 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:18101 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261455AbULTGPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:15:19 -0500
Cc: openib-general@openib.org
In-Reply-To: <200412192215.96NE5c2UPDke8PZm@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 19 Dec 2004 22:15:18 -0800
Message-Id: <200412192215.XIYuLGzemoQZ9LxY@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v4][22/24] Document InfiniBand ioctl use
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 20 Dec 2004 06:15:19.0098 (UTC) FILETIME=[479B29A0:01C4E65B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 0x1b ioctl magic number used by ib_umad module to
Documentation/ioctl-number.txt.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/Documentation/ioctl-number.txt	2004-12-19 21:09:51.000000000 -0800
+++ linux-bk/Documentation/ioctl-number.txt	2004-12-19 22:04:19.307853857 -0800
@@ -72,6 +72,7 @@
 0x09	all	linux/md.h
 0x12	all	linux/fs.h
 		linux/blkpg.h
+0x1b	all	InfiniBand Subsystem	<http://www.openib.org/>
 0x20	all	drivers/cdrom/cm206.h
 0x22	all	scsi/sg.h
 '#'	00-3F	IEEE 1394 Subsystem	Block for the entire subsystem

