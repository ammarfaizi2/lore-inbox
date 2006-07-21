Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWGUNsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWGUNsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 09:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWGUNsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 09:48:04 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:53896 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750732AbWGUNsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 09:48:02 -0400
Date: Fri, 21 Jul 2006 09:47:22 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: LKML <linux-kernel@vger.kernel.org>
cc: akpm@osdl.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] reference rt-mutex-design in rtmutex.c
Message-ID: <Pine.LNX.4.58.0607210942410.1190@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In order to prevent Doc Rot, this patch adds a reference to the design
document for rtmutex.c in rtmutex.c.  So when someone needs to update or
change the design of that file they will know that a document actually
exists that explains the design (helping them change it), as well as
letting them know that they need to update it if it becomes out of date.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc2/kernel/rtmutex.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/rtmutex.c	2006-07-21 09:38:08.000000000 -0400
+++ linux-2.6.18-rc2/kernel/rtmutex.c	2006-07-21 09:36:05.000000000 -0400
@@ -7,6 +7,9 @@
  *  Copyright (C) 2005-2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
  *  Copyright (C) 2005 Kihon Technologies Inc., Steven Rostedt
  *  Copyright (C) 2006 Esben Nielsen
+ *
+ *  Before making any design changes to this file, please refer to
+ *  Documentation/rt-mutex-design.txt and update accordingly.
  */
 #include <linux/spinlock.h>
 #include <linux/module.h>
