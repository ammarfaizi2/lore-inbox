Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUALRYm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265536AbUALRYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:24:42 -0500
Received: from aun.it.uu.se ([130.238.12.36]:31404 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266212AbUALRYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:24:39 -0500
Date: Mon, 12 Jan 2004 18:24:23 +0100 (MET)
Message-Id: <200401121724.i0CHONeP023816@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.6.4 released with PPC32 support
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       perfapi-devel@NACSE.ORG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.4 of perfctr, the Linux performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

Three architectures are now supported: x86, AMD64, and PPC32.

Since I only have a PPC750, I'm looking for testers with 74xx
or 604 processors. Even if you don't intend to use the driver,
booting a kernel configured with CONFIG_PERFCTR_INIT_TESTS=y,
loading the driver module (if not built-in), and emailing me the
PERFCTR INIT kernel log messages would be helpful.

Version 2.6.4, 2004-01-12
- Added support for PowerPC 604/7xx/74xx processors.
  * Overflow interrupts are not yet supported due to a hardware
    erratum affecting many 7xx and early 74xx processors.
  * The user-space components support PowerPC, but CPU detection
    and event set descriptions are not yet implemented.
  * Supported in 2.6.1 and 2.4.23 and newer 2.4 kernels.
- Updated kernel support: 2.6.1, 2.4.25-pre4, 2.4.22-1.2140.nptl
  (FC1 update), 2.4.21-4.0.2.EL (RHEL update), and 2.4.20-28.x
  (RH 7.x/8.0/9 update).

/ Mikael Pettersson
