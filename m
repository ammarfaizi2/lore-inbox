Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTEPNdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 09:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTEPNdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 09:33:12 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:63920 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264432AbTEPNdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 09:33:11 -0400
Date: Fri, 16 May 2003 15:45:37 +0200 (MEST)
Message-Id: <200305161345.h4GDjbc5000236@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.5.3 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.5.3 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

x86_64 is now supported in kernels 2.5.69, 2.4.21-rc2, and
RawHide's 2.4.20-9.2 (GinGin64 RH 8.0.95 preview). Successfully
tested on a dual Opteron box. The x86_64 control data is
different than the x86 control data (P5 and P4 control has
been removed), so applications must be recompiled for x86_64.

Version 2.5.3, 2003-05-16
- Added support for the Pentium M processor. It is mostly like
  a Pentium III with some more events, except that six old
  Pentium III / Pentium Pro events have been redefined.
- Added support for K8 in 64-bit mode (the x86_64 kernel arch).
  Updated driver, user-space library, and example programs.
  The shared library libperfctr.so is now compiled with -fPIC.
- K8 bug fix in examples/signal/signal.c: a missing INT flag
  caused the driver to reject the control setup.
- P4 event descriptions updated from recent documentation changes.

/ Mikael Pettersson
