Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTIPDMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbTIPDMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:12:08 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:52609 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261785AbTIPDLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:11:44 -0400
Message-ID: <1063681808.3f667f10b8344@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:10:08 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 14 of 15 -- /net/core/dev.c
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


diff -Nur linux-2.6.0-test4-bk5-mandocs/net/core/dev.c
linux-2.6.0-test4-bk5-mandocs_tweaks/net/core/dev.c
--- linux-2.6.0-test4-bk5-mandocs/net/core/dev.c	2003-09-04 10:57:06.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/net/core/dev.c	2003-09-09
15:21:25.000000000 +1000
@@ -912,6 +912,8 @@
 
 /**
  *	call_netdevice_notifiers - call all network notifier blocks
+ *      @val: value passed unmodified to notifier function
+ *      @v:   pointer passed unmodified to notifier function
  *
  *	Call all network notifier blocks.  Parameters and return value
  *	are as for notifier_call_chain().

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
