Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWIAIR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWIAIR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 04:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWIAIR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 04:17:27 -0400
Received: from server6.greatnet.de ([83.133.96.26]:22697 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750783AbWIAIR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 04:17:26 -0400
Message-ID: <44F7ECC3.7000806@nachtwindheim.de>
Date: Fri, 01 Sep 2006 10:18:11 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [KERNELDOC] add missing desctiption in super.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Adds kernel-doc for alloc_super() type in fs/super.c.
This should be merged into linus tree before 2.6.18.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---

--- linux-2.6.17-git22/fs/super.c	2006-07-04 11:12:16.000000000 +0200
+++ linux/fs/super.c	2006-07-04 14:07:00.000000000 +0200
@@ -49,6 +49,7 @@
 
 /**
  *	alloc_super	-	create new superblock
+ *	@type:	filesystem type superblock should belong to
  *
  *	Allocates and initializes a new &struct super_block.  alloc_super()
  *	returns a pointer new superblock or %NULL if allocation had failed.


