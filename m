Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129691AbQKUJyW>; Tue, 21 Nov 2000 04:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbQKUJyM>; Tue, 21 Nov 2000 04:54:12 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:26794 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129691AbQKUJyD>;
	Tue, 21 Nov 2000 04:54:03 -0500
Date: Tue, 21 Nov 2000 10:23:59 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200011210923.KAA17750@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [Announce] Version 1.6 of x86 performance counters driver
Cc: mucci@cs.utk.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 1.6 of my x86 performance-monitoring counters driver is
now available at http://www.csd.uu.se/~mikpe/linux/perfctr/.

Summary of changes since version 1.5:
Version 1.6, 2000-11-21
- Updated for kernels 2.4.0-test11 and 2.2.18pre22.
- Preliminary implementation of /proc/self/perfctr as a more direct
  way of accessing one's virtual perfctrs. (If this works out,
  the /dev/perfctr interface to vperfctrs will be phased out.)
  The driver can still be built as an autoloadable module.
  (For now, only supported in 2.2.18pre22 and 2.4.0-test11.)
- Some user-space library API changes to accommodate /proc/self/perfctr.
- The per-process virtual TSC is no longer restarted from zero
  when the perfctrs are reprogrammed, which allows it to be used
  as a high-res per-process clock (i.e. gethrvtime()).
- Rewrote the `command' example application to use perfctr inheritance
  instead of the recently removed "remote control" facility.
- WinChip documentation updates and corrections.


/ Mikael Pettersson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
