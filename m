Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131189AbRBMWW3>; Tue, 13 Feb 2001 17:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131228AbRBMWWT>; Tue, 13 Feb 2001 17:22:19 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:58573 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S131189AbRBMWWE>;
	Tue, 13 Feb 2001 17:22:04 -0500
Date: Tue, 13 Feb 2001 23:22:02 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200102132222.XAA26192@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, perfapi-devel@ptools.org
Subject: [Announce] Version 1.9 of x86 performance counters driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 1.9 of my x86 performance-monitoring counters driver is
now available at http://www.csd.uu.se/~mikpe/linux/perfctr/.

Summary:
Version 1.9, 2001-02-13
- Fixed compilation problems for 2.2 and SMP kernels.
  [Caused by the kernel not passing "-nostdinc" to gcc, and
  RedHat 7.0 including 2.4.0 kernel headers in /usr/include/.]
- Corrected VIA Cyrix III support. The "VIA Cyrix III" product
  has apparently used two distinct CPUs. Initial CPUs were a
  Cyrix design (Joshua) while current CPUs apparently are a
  Centaur design (Samuel). Added support for "Samuel" CPUs.
  [NOTE: This could use some testing on real HW. Any volunteers?]
- Two corrections in the K7 perfctr event list.
- Small tweaks to vperfctr interrupt handling.
- Added preliminary interrupt-mode support for AMD K7.

Future changes on the perfctr-1.x branch will be limited to bug
fixes and updated glue patches for new 2.2 kernels. New features
and hardware support will be implemented in the perfctr-2.x branch,
but it will only support 2.4/2.5 kernels. (Sorry, but maintaining
compatibility with 2.2 kernels is taking too much of my time.)


/ Mikael Pettersson
