Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTDMNGq (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 09:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTDMNG3 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 09:06:29 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:7356 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263510AbTDMNEk (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 09:04:40 -0400
Date: Sun, 13 Apr 2003 15:16:05 +0200 (MEST)
Message-Id: <200304131316.h3DDG5Ka005141@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.5.2 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.5.2 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

Version 2.5.2, 2003-04-13
- Updated power management code for the local APIC and NMI
  watchdog driver model changes in kernel 2.5.67.
- Timer-based sampling of per-process performance counters is
  now always enabled: previously it was only done on SMP.
  Needed to avoid counter inaccuracies on high core-clock CPUs.
- Fixes to user-space library implementation of remote-control
  virtual performance counters: open() failed due to a missing
  return; avoid potential buffer overflow error; fix the "read
  counters" procedure for the case where the remote process is
  sampling the time-stamp counter but no performance counters.
- Added support for RedHat 9's 2.4.20-8 and 2.4.20-9 kernels.

/ Mikael Pettersson
