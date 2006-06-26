Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933254AbWFZWiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933254AbWFZWiu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933248AbWFZWia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:30 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:64415 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933226AbWFZWiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:23 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 21/32] [Suspend2] Set device info.
Date: Tue, 27 Jun 2006 08:38:22 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223820.4376.8054.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the list of devices and blocks to use for i/o.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 6e0f22c..3902758 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -775,3 +775,8 @@ static unsigned long suspend_bio_memory_
 				sizeof(struct bio) + sizeof(struct io_info)));
 }
 
+static void suspend_set_devinfo(struct suspend_bdev_info *info)
+{
+	suspend_devinfo = info;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
