Return-Path: <linux-kernel-owner+w=401wt.eu-S1161280AbXAMFJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbXAMFJN (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 00:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbXAMFJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 00:09:13 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:1794 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161280AbXAMFJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 00:09:13 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:x-x-sender:to:subject:message-id:mime-version:content-type;
        b=P3uFiwVS/FAczoEak5kmBZCeOPHMRbfnOIxN5YFpan5rWysM/G6dP1mFIGptxUufj2jVJlly55oGhu9B6VzLS4TUjJCGZjADgO1gWZiIVgGWQEQMutNZrORroV5Ig2NechZ1lJVzbZlt5UUP/YkX9ZV4bP3k0BS3BgHALtZldCQ=
Date: Sat, 13 Jan 2007 13:09:04 +0800 (SGT)
From: Jeff Chua <jeff.chua.linux@gmail.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.15-rc5 - removes "video device notify" message (fwd)
Message-ID: <Pine.LNX.4.64.0701131308130.22948@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here's a line fix to ignore the "video device notify" message ...

--- linux/drivers/acpi/video.c.org	2007-01-12 23:05:23 +0800
+++ linux/drivers/acpi/video.c	2007-01-12 23:05:29 +0800
@@ -1771,1 +1771,1 @@
-	printk("video device notify\n");
+	//printk("video device notify\n");



Thanks,
Jeff
