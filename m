Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264978AbSKIEP7>; Fri, 8 Nov 2002 23:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265091AbSKIEP7>; Fri, 8 Nov 2002 23:15:59 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:12 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264978AbSKIEP6>;
	Fri, 8 Nov 2002 23:15:58 -0500
Date: Fri, 8 Nov 2002 23:22:41 -0500 (EST)
Message-Id: <200211090422.gA94Mfn244751@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] procps 3.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This includes the first noticeable vmstat change. Now you get
IO-wait time separate from idle time if you run Linux 2.5.41
or later.

There's a Solaris-compatible pmap as well, lacking only the
per-vma resident memory stats that Linux doesn't supply.
(hint, hint... though I don't know where they'd fit)

http://procps.sf.net/
http://procps.sf.net/procps-3.1.0.tar.gz

------------- recent changes -------------

procps-3.0.5 --> procps-3.1.0

vmstat displays IO-wait time instead of bogus "w"
can build w/o shared library (set SHARED=0)
when IO-wait hidden, count as idle, not as sys
pmap command added (like Sun has)
do not crash GNU make 3.79
top slightly faster

procps-3.0.4 --> procps-3.0.5

top tolerates super-wide displays
better (?) RPM generation
XConsole and top.desktop removed
old build system removed
code cleanup
pgrep and pkill get "-o" (oldest matching process)
had vmstat "bi" and "bo" output interchanged on 2.5.xx
fix man page tbl directives
top man page cleaned up

-----------------------------------------
