Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTKWNoq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 08:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTKWNoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 08:44:46 -0500
Received: from aun.it.uu.se ([130.238.12.36]:62860 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262598AbTKWNop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 08:44:45 -0500
Date: Sun, 23 Nov 2003 14:44:37 +0100 (MET)
Message-Id: <200311231344.hANDibuw003762@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.6.2 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.2 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

I've now also made .rpm files for the user-space components.
Please try them out and report any glitches.

Version 2.6.2, 2003-11-23
- libperfctr.so is now installed with proper versioning.
- ABI control and info structures padded to accommodate some
  extensions without breaking application/library binary
  compatibility. ABI version incremented to '5'.
- Driver checks that only P4 models <= 2 use IQ_ESCR0/1.
- Added support for Fedora Core 1's 2.4.22-1.2115.nptl kernel.
- Driver compile fix for AMD64 in SMP 2.6 kernels.

/ Mikael Pettersson
