Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313512AbSC3SQT>; Sat, 30 Mar 2002 13:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313513AbSC3SQJ>; Sat, 30 Mar 2002 13:16:09 -0500
Received: from zero.tech9.net ([209.61.188.187]:37125 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313512AbSC3SP7>;
	Sat, 30 Mar 2002 13:15:59 -0500
Subject: [PATCH] 2.4: updated preemptive kernel patch
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 30 Mar 2002 13:16:02 -0500
Message-Id: <1017512162.2941.134.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the preemptive kernel patch, supported by MontaVista.  Updated
patches for 2.4.18, 2.4.19-pre5, and 2.4.19-pre4-ac3 are now available
at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel

as well as older patches for older kernel revisions.

The only major change aside from the sync up is some simple debug code
that will catch most any preempt_count oddity without much overhead,
courtesy of Andrew Morton.  Basically just check the preempt_count for a
non-zero value on do_exit.

Nothing pending in the 2.4 codebase.  I have a bunch of changes queued
for preempt-stats which I will get out real soon now.  For 2.5, there
are a couple of indirect preempt-related optimizations and lock-fixings
in store soon.

Recent Change Log:

20020328

- simple but complete debug check in do_exit	(Andrew Morton)

20020301:

- fix the preempt_count for non-CPU0 idle       (George Anzinger)
  threads

Enjoy,

	Robert Love

