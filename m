Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbTD3SUK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 14:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTD3SUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 14:20:10 -0400
Received: from pointblue.com.pl ([62.89.73.6]:57610 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262279AbTD3SUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:20:10 -0400
Subject: [PATCH] 2.5.68-bk10 net/core/netfilter.c, missing "i" declaration
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linus <torvalds@transmeta.com>, Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1051727542.21774.18.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Apr 2003 19:32:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -r -u linux-2.5.68-bk10-changed/net/core/netfilter.c
linux-2.5.68-bk10-org/net/core/netfilter.c
--- linux-2.5.68-bk10-changed/net/core/netfilter.c      2003-04-30
19:30:20.000000000 +0100
+++ linux-2.5.68-bk10-org/net/core/netfilter.c  2003-04-30
19:27:57.000000000 +0100
@@ -550,6 +550,7 @@
                 unsigned int verdict)
 {
        struct list_head *elem = &info->elem->list;
+       struct list_head *i;


        rcu_read_lock();


-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

