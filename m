Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbTAROWV>; Sat, 18 Jan 2003 09:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTAROWU>; Sat, 18 Jan 2003 09:22:20 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:25221 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264822AbTAROWT>;
	Sat, 18 Jan 2003 09:22:19 -0500
Date: Sat, 18 Jan 2003 15:31:19 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301181431.PAA14360@harpo.it.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.4.4 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.4.4 is now available at the usual place:
http://www.csd.uu.se/~mikpe/linux/perfctr/

Version 2.4.4, 2003-01-18
- Fixed a context-switch bug where an interrupt-mode counter could
  increment unexpectedly, and also miss the overflow interrupt.
- Fixed some ugly log messages the new HT P4 support code added
  in perfctr-2.4.3 could generate at driver initialisation time.
- Added preliminary support for AMD K8 processors with the
  regular 32-bit x86 kernel. The K8 performance counters appear
  to be identical or very similar to the K7 performance counters.

/ Mikael Pettersson
