Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTDUPSS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTDUPSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:18:17 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:34542 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261328AbTDUPR0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:17:26 -0400
Message-ID: <3EA40CC7.7040305@cox.net>
Date: Mon, 21 Apr 2003 08:22:47 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Remove extraneous devpts help text
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that devfs no longer provides devpts functionality, remove help text 
for devpts that implies that it does.

--- linux-2.5/fs/Kconfig.old	Mon Apr 21 08:25:43 2003
+++ linux-2.5/fs/Kconfig	Mon Apr 21 08:26:28 2003
@@ -800,9 +800,6 @@
  	  API. Please read <file:Documentation/Changes> for more information
  	  about the Unix98 pty devices.

-	  Note that the experimental "/dev file system support"
-	  (CONFIG_DEVFS_FS)  is a more general facility.
-
  config TMPFS
  	bool "Virtual memory file system support (former shm fs)"
  	help


