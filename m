Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbSKYOry>; Mon, 25 Nov 2002 09:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSKYOry>; Mon, 25 Nov 2002 09:47:54 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:47100 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S263589AbSKYOry>;
	Mon, 25 Nov 2002 09:47:54 -0500
Date: Mon, 25 Nov 2002 15:55:08 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200211251455.PAA15960@harpo.it.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.4.2 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.4.2 is now available at the usual place:
http://www.csd.uu.se/~mikpe/linux/perfctr/

The perfctr-2.4 branch is again the main branch. The perfctr-3.1
branch is suspended since (a) it's only purpose was to be a cleaned
up version for the 2.5 kernel, (b) it was ignored w/o comment, and
(c) it removed too many features (module support, old kernels support)
in its attempt to be as clean as possible.

Proper support for hyper-threaded P4s is next on my TODO list.

Version 2.4.2, 2002-11-25
- Fixed a driver bug where it could fail to prevent simultaneous
  use of global-mode and per-process performance counters.
- Made the driver safe for preemptible 2.5 kernels.
- New patches for RedHat update kernels 2.2.22-6.2.2, 2.2.22-7.0.2,
  2.4.18-18.7.x, and 2.4.18-18.8.0.

/ Mikael Pettersson
