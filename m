Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUG1UwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUG1UwC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUG1UwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:52:02 -0400
Received: from av5-2-sn3.vrr.skanova.net ([81.228.9.114]:3531 "EHLO
	av5-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S263761AbUG1Uvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:51:54 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Trivial CDRW packet writing doc update
From: Peter Osterlund <petero2@telia.com>
Date: 28 Jul 2004 22:36:51 +0200
Message-ID: <m3llh3uavw.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Document that pktcdvd block devices have a 2KB block size.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/Documentation/cdrom/packet-writing.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN Documentation/cdrom/packet-writing.txt~packet-doc-update Documentation/cdrom/packet-writing.txt
--- linux/Documentation/cdrom/packet-writing.txt~packet-doc-update	2004-07-28 22:00:19.047078592 +0200
+++ linux-petero/Documentation/cdrom/packet-writing.txt	2004-07-28 22:00:19.049078288 +0200
@@ -71,8 +71,8 @@ Notes
   filesystem corruption if the disc wears out.
 
 - Since the pktcdvd driver makes the disc appear as a regular block
-  device, you can put any filesystem you like on the disc. For
-  example, run:
+  device with a 2KB block size, you can put any filesystem you like on
+  the disc. For example, run:
 
 	# /sbin/mke2fs /dev/pktcdvd/dev_name
 
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
