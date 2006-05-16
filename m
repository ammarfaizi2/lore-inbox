Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWEPG2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWEPG2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 02:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWEPG2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 02:28:43 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:40858 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751524AbWEPG2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 02:28:43 -0400
Date: Tue, 16 May 2006 02:28:27 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: akpm@osdl.org
cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH -mm 04/02] Update rt-mutex-design.txt per Randy Dunlap
In-Reply-To: <Pine.LNX.4.58.0605150511440.12114@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605160226420.4283@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605150431190.12114@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605150511440.12114@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Small grammar fix.

From: Randy.Dunlap <rdunlap@xenotime.net>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt
===================================================================
--- linux-2.6.17-rc3-mm1.orig/Documentation/rt-mutex-design.txt	2006-05-16 02:23:49.000000000 -0400
+++ linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt	2006-05-16 02:24:25.000000000 -0400
@@ -160,7 +160,7 @@ Here we show both chains:
                  F->L5-+

 For PI to work, the processes at the right end of these chains (or we may
-also call the Top of the chain) must be equal to or higher in priority
+also call it the Top of the chain) must be equal to or higher in priority
 than the processes to the left or below in the chain.

 Also since a mutex may have more than one process blocked on it, we can
