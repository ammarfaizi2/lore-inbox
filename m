Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTIPDOb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbTIPDMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:12:13 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:52097 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261783AbTIPDLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:11:44 -0400
Message-ID: <1063681781.3f667ef5da671@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:09:41 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 13 of 15 -- /mm/slab.c
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


diff -Nur linux-2.6.0-test4-bk5-mandocs/mm/slab.c
linux-2.6.0-test4-bk5-mandocs_tweaks/mm/slab.c
--- linux-2.6.0-test4-bk5-mandocs/mm/slab.c	2003-09-04 10:57:24.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/mm/slab.c	2003-09-06 19:35:38.000000000
+1000
@@ -2642,8 +2642,8 @@
  * slabinfo_write - Tuning for the slab allocator
  * @file: unused
  * @buffer: user buffer
- * @count: data len
- * @data: unused
+ * @count: data length
+ * @ppos: unused
  */
 ssize_t slabinfo_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
