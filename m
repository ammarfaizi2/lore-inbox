Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbUBUQ6p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 11:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUBUQ6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 11:58:45 -0500
Received: from aun.it.uu.se ([130.238.12.36]:10473 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261577AbUBUQ6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 11:58:43 -0500
Date: Sat, 21 Feb 2004 17:58:35 +0100 (MET)
Message-Id: <200402211658.i1LGwZbq028010@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.6.6 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.6 of perfctr, the Linux performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

Version 2.6.6, 2004-02-21
- Pentium-M has an undocumented local APIC quirk which can stop
  perfctr interrupt delivery. Added workaround to prevent this.
- Fixed a bug in x86-64's perfctr interrupt entry code in 2.4 kernels.
  Luckily, the bug turned out to be harmless (a bogus "rip" value was
  retrieved, but never used by the higher-level interrupt handler).
- Added support for Pentium 4 Model 3 processors, which have slight
  event set changes from earlier models.
- Updated kernel support: 2.6.3, 2.4.25, 2.4.22-1.2174.nptl (FC1),
  2.4.20-30.9 (RH9), and 2.4.21-193 (SuSE). Removed support for some
  obsolete FC1 and RH update kernels.

/ Mikael Pettersson
