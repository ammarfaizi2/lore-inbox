Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbTBTKAX>; Thu, 20 Feb 2003 05:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTBTKAW>; Thu, 20 Feb 2003 05:00:22 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:50421 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S265096AbTBTKAW>;
	Thu, 20 Feb 2003 05:00:22 -0500
Date: Thu, 20 Feb 2003 11:10:04 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200302201010.h1KAA4dW023443@harpo.it.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.5.0-pre1 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.5.0-pre1 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

This is a development snapshot. Although it should work well,
it is not binary or API compatible with the current stable
version (2.4.5).

Version 2.5.0-pre1, 2003-02-19
- Fixed the driver's API to support global-mode perfctrs on 2.5
  SMP kernels and asymmetric hyper-threaded P4 multiprocessors.
  Updated examples/global/global.c for the new API.
- Minor library cleanups. Updated example programs accordingly.
- API cleanup: Removed obsolete STOP command from the driver
  for virtual perfctrs. The library now uses CONTROL instead.
- Proper detection and support for AMD K8 processors. They are
  similar to the K7s, but the event sets are not identical.
- The library's event set descriptions have been redesigned and
  expanded to include unit mask descriptions and descriptions of
  Intel P4 and AMD K8 events. The etc/perfctr-events.tab text file
  has been removed since event_codes.h now is generated from the
  library's data structures.

/ Mikael Pettersson
