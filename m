Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTLUPH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 10:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTLUPH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 10:07:28 -0500
Received: from aun.it.uu.se ([130.238.12.36]:8323 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263281AbTLUPH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 10:07:27 -0500
Date: Sun, 21 Dec 2003 16:07:19 +0100 (MET)
Message-Id: <200312211507.hBLF7JBD009675@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.6.3 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.3 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

Version 2.6.3, 2003-12-21
- Fixed a bug where a read of the global-mode counters could
  fail with EOVERFLOW due to an incorrect structure descriptor.
  The bug only existed in perfctr-2.6.2.
  (Thanks to Pavel Machek for reporting this problem.)
- AMD64 IA32 emulation code cleaned up for kernel 2.4.23.
- Updated kernel support: 2.6.0, 2.4.24-pre1, 2.4.23,
  2.4.22-1.2129.nptl (FC1 update), 2.4.21-1.1931.2.393.ent
  (RHEL Taroon beta), and 2.4.20-24 (RH 7.x/8/9 update).
- User-space package rpm spec file fixes:
  * Don't remove /dev/perfctr on package uninstall.
  * Don't add alias to /etc/modules.conf if it's already there.

/ Mikael Pettersson
