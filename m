Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTIPDBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTIPDBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:01:38 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:63981 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261669AbTIPDBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:01:37 -0400
Message-ID: <1063681289.3f667d09e6972@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:01:29 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 1 of 15 -- /arch/i386/kernel/mca.c
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


diff -Nur linux-2.6.0-test4-bk5-mandocs/arch/i386/kernel/mca.c
linux-2.6.0-test4-bk5-mandocs_tweaks/arch/i386/kernel/mca.c
--- linux-2.6.0-test4-bk5-mandocs/arch/i386/kernel/mca.c	2003-09-04
10:56:13.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/arch/i386/kernel/mca.c	2003-09-06
13:41:38.000000000 +1000
@@ -132,7 +132,9 @@
 #define MCA_STANDARD_RESOURCES	(sizeof(mca_standard_resources)/sizeof(struct
resource))
 
 /**
- *	mca_read_pos - read the POS registers into a memory buffer
+ *	mca_read_and_store_pos - read the POS registers into a memory buffer
+ *      @pos: a char pointer to 8 bytes, contains the POS register value on
+ *            successful return
  *
  *	Returns 1 if a card actually exists (i.e. the pos isn't
  *	all 0xff) or 0 otherwise

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
