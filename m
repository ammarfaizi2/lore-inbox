Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbUJXNG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUJXNG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbUJXNG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:06:27 -0400
Received: from verein.lst.de ([213.95.11.210]:54693 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261467AbUJXNGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:06:10 -0400
Date: Sun, 24 Oct 2004 15:05:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport firmware_class
Message-ID: <20041024130559.GA19488@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it's marked static already, and there's no point in exporting it


--- 1.22/drivers/base/firmware_class.c	2004-10-20 10:37:11 +02:00
+++ edited/drivers/base/firmware_class.c	2004-10-23 14:37:21 +02:00
@@ -583,4 +583,3 @@
 EXPORT_SYMBOL(request_firmware);
 EXPORT_SYMBOL(request_firmware_nowait);
 EXPORT_SYMBOL(register_firmware);
-EXPORT_SYMBOL(firmware_class);
