Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWEOJNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWEOJNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWEOJNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:13:42 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:27272 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751330AbWEOJNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:13:41 -0400
Date: Mon, 15 May 2006 05:13:28 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: akpm@osdl.org
cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH -mm 03/02] Update rt-mutex-design.txt per Randy Dunlap
In-Reply-To: <Pine.LNX.4.58.0605150431190.12114@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605150511440.12114@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605150431190.12114@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add blank line under index 1) in rt-mutex-design.txt.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt
===================================================================
--- linux-2.6.17-rc3-mm1.orig/Documentation/rt-mutex-design.txt	2006-05-15 05:10:22.000000000 -0400
+++ linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt	2006-05-15 05:10:25.000000000 -0400
@@ -598,6 +598,7 @@ owner.  Let's look at the situations we

   1) Has owner that is pending
   ----------------------------
+
   The mutex has a owner, but it hasn't woken up and the mutex flag
   "Pending Owner" is set.  The first check is to see if the owner isn't the
   current task.  This is because this function is also used for the pending
