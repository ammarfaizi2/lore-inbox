Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTFOWQF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 18:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTFOWQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 18:16:05 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:62411 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262918AbTFOWQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 18:16:04 -0400
Date: Mon, 16 Jun 2003 00:29:36 +0200 (MEST)
Message-Id: <200306152229.h5FMTa93026063@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.5.5 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.5.5 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

x86-64 users please note that the 2.5.71 kernel won't
compile on x86-64 due to incomplete 'driver model' changes.
A patch to fix this and two other x86-64 bugs is in the
patch-x86_64-2.5.71 file in perfctr's download directory.

Version 2.5.5, 2003-06-15
- Updates for driver model changes in kernel 2.5.71.
- Minor updates to the library's event descriptions for Pentium 4.
- Now supports SuSE's 2.4.19.SuSE-206 kernel for SLES 8 users.
  Autodetection of SuSE kernel versions is not yet implemented:
  pass "--patch=2.4.19.SuSE-206" to perfctr's update-kernel script
  to ensure that the correct patch is applied.
- Patch kit updates for 2.4.21 final and 2.4.20-18 RH kernels.

/ Mikael Pettersson
