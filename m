Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTIPDJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTIPDHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:07:08 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:47488 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261778AbTIPDGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:06:10 -0400
Message-ID: <1063681561.3f667e195ddf3@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:06:01 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 10 of 15 -- /include/linux/list.h
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


diff -Nur linux-2.6.0-test4-bk5-mandocs/include/linux/list.h
linux-2.6.0-test4-bk5-mandocs_tweaks/include/linux/list.h
--- linux-2.6.0-test4-bk5-mandocs/include/linux/list.h	2003-09-04
10:56:53.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/include/linux/list.h	2003-09-06
13:47:15.000000000 +1000
@@ -436,7 +436,7 @@
 
 /**
  * hlist_del_rcu - deletes entry from hash list without re-initialization
- * @entry: the element to delete from the hash list.
+ * @n: the element to delete from the hash list.
  *
  * Note: list_unhashed() on entry does not return true after this, 
  * the entry is in an undefined state. It is useful for RCU based

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
