Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTGBBS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 21:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTGBBS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 21:18:28 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:55991 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264507AbTGBBS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 21:18:27 -0400
Date: Wed, 2 Jul 2003 03:32:29 +0200 (MEST)
Message-Id: <200307020132.h621WT0Z016549@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.6.0-pre1 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.0-pre1 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

After this there will be one or more further -pre versions with
changes to the kernel/user-space API, which are needed to ensure
binary compatibility between x86 and x86-64, and to permit future
extensions without breaking ABIs.

Version 2.6.0-pre1, 2003-07-02
- Rearranged the data structure holding the counter state to
  reduce the number of caches lines needed to be touched at key
  operations. The new representation is also binary compatible
  between x86 and x86-64, which matters since user-space mmaps() it.
- Added RPM spec file for the library. (From Bryan O'Sullivan).
- Patch kit updated for kernels 2.4.22-pre2 and 2.5.73.

/ Mikael Pettersson
