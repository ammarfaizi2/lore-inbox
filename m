Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTIPDMC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTIPDJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:09:50 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:57216 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261767AbTIPDG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:06:58 -0400
Message-ID: <1063681611.3f667e4bb3573@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:06:51 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 12 of 15 -- /kernel/kmod.c
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


diff -Nur linux-2.6.0-test4-bk5-mandocs/kernel/kmod.c
linux-2.6.0-test4-bk5-mandocs_tweaks/kernel/kmod.c
--- linux-2.6.0-test4-bk5-mandocs/kernel/kmod.c	2003-09-04 10:57:23.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/kernel/kmod.c	2003-09-09
15:49:15.000000000 +1000
@@ -47,7 +47,8 @@
 
 /**
  * request_module - try to load a kernel module
- * @module_name: Name of module
+ * @fmt:     printf style format string for the name of the module
+ * @varargs: arguements as specified in the format string
  *
  * Load a module using the user mode module loader. The function returns
  * zero on success or a negative errno code on failure. Note that a

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
