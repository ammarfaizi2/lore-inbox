Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWGZMcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWGZMcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWGZMcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:32:21 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:34774 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751496AbWGZMcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:32:20 -0400
Subject: [PATCH V2] reference rt-mutex-design in rtmutex.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060726081631.GC11604@elte.hu>
References: <Pine.LNX.4.58.0607210942410.1190@gandalf.stny.rr.com>
	 <20060726081631.GC11604@elte.hu>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 08:30:47 -0400
Message-Id: <1153917047.6270.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[V2 - update per Ingo's request]

In order to prevent Doc Rot, this patch adds a reference to the design
document for rtmutex.c in rtmutex.c.  So when someone needs to update or
change the design of that file they will know that a document actually
exists that explains the design (helping them change it), and hopefully
that they will update the document if they too change the design.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc2/kernel/rtmutex.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/rtmutex.c	2006-07-16 19:53:46.000000000 -0400
+++ linux-2.6.18-rc2/kernel/rtmutex.c	2006-07-26 08:24:14.000000000 -0400
@@ -7,6 +7,8 @@
  *  Copyright (C) 2005-2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
  *  Copyright (C) 2005 Kihon Technologies Inc., Steven Rostedt
  *  Copyright (C) 2006 Esben Nielsen
+ *
+ *  See Documentation/rt-mutex-design.txt for details.
  */
 #include <linux/spinlock.h>
 #include <linux/module.h>


