Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbTIPDGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTIPDEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:04:50 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:17536 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261772AbTIPDEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:04:32 -0400
Message-ID: <1063681457.3f667db167a85@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:04:17 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 6 of 15 -- /fs/devfs/base.c
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 203.17.68.210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes kernel-doc errors reported whilst doing
a make mandocs on 2.6-test4-bk5

Linus, please apply.

Cheers,
Mikal


--------------------------


diff -Nur linux-2.6.0-test4-bk5-mandocs/fs/devfs/base.c
linux-2.6.0-test4-bk5-mandocs_tweaks/fs/devfs/base.c
--- linux-2.6.0-test4-bk5-mandocs/fs/devfs/base.c	2003-09-04 10:57:04.000000000
+1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/fs/devfs/base.c	2003-09-09
19:19:33.000000000 +1000
@@ -974,8 +974,9 @@
 
 /**
  *	_devfs_alloc_entry - Allocate a devfs entry.
- *	@name:  The name of the entry.
- *	@namelen:  The number of characters in @name.
+ *	@name:     the name of the entry
+ *	@namelen:  the number of characters in @name
+ *      @mode:     the mode for the entry
  *
  *  Allocate a devfs entry and returns a pointer to the entry on success, else
  *   %NULL.

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
