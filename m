Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262986AbTCWJdk>; Sun, 23 Mar 2003 04:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262990AbTCWJdk>; Sun, 23 Mar 2003 04:33:40 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:47561 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S262986AbTCWJdj>;
	Sun, 23 Mar 2003 04:33:39 -0500
Date: Sun, 23 Mar 2003 10:44:23 +0100 (MET)
Message-Id: <200303230944.h2N9iNGJ007871@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.5.1 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.5.1 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

Version 2.5.1, 2003-03-23
- Fixed initialisation on hyper-threading capable P4s in
  SMP kernels older than 2.4.15 to not signal an error if
  hyper-threading is disabled: in this case the absence of
  working set_cpus_allowed() support is not a problem.
- Fixed two compilation errors in the set_cpus_allowed()
  emulation affecting old 2.4 kernels configured for SMP.
- INSTALL file updates.

/ Mikael Pettersson
