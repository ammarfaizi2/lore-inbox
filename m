Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVLANZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVLANZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVLANZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:25:57 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:41657 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S932228AbVLANZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:25:56 -0500
Subject: [PATCH 3/4] linux-2.6-block: deactivating pagecache for benchmarks
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 14:25:47 +0100
Message-Id: <1133443547.6110.43.camel@noti>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the Makefile in linux/block

Signed-Off-By: Dirk Gerdes <mail@dirk-gerdes.de>

---



--- linux-2.6-block_clean/block/Makefile	2005-11-30 16:12:30.000000000
+0100
+++ linux-2.6-block-pagecache-clean/block/Makefile	2005-11-30 17:14:40.000000000 +0100
@@ -8,3 +8,4 @@ obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosch
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
 obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
 obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
+obj-$(CONFIG_PAGECACHE_TOGGLE)        += pagecache.o

