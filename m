Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272723AbSISUB4>; Thu, 19 Sep 2002 16:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272779AbSISUB4>; Thu, 19 Sep 2002 16:01:56 -0400
Received: from nameservices.net ([208.234.25.16]:22876 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S272723AbSISUBz>;
	Thu, 19 Sep 2002 16:01:55 -0400
Message-ID: <3D8A2F2E.F8E935D2@opersys.com>
Date: Thu, 19 Sep 2002 16:10:22 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: LTT 0.9.6pre1: Lockless logging, ARM, MIPS, etc.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A new development version of LTT, 0.9.6pre1, is now available.
At this point, LTT supports 6 architectures:
i386, PPC, S/390, ARM, SuperH, and MIPS.

Here's what's in 0.9.6pre1:
- Lockless logging implementation a-la K42 by Tom Zanussi (IBM).
  This was added to the 2.5.x patch series only.
- ARM port by Frank Rowand (MontaVista).
- MIPS port update/cleanup by Frank Rowand (MontaVista).
- Autotools update by Andrea Cisternino (ST Micro) and Frank
  Rowand (MontaVista)
- Added RTAI install script by Klaas Gadeyne to Examples/ directory.
- Added arch/mips/timer.c instrumentation by Bino Mathew (Wipro).
- Fixes for keeping track of event details by Andreas Heppel (Sysgo).
- Fixes for SMP trace analysis by Frank Rowand (MontaVista).
- Moved max limit of IRQ to 256 for XScale by Frank Rowand (MontaVista).

The lockless logging feature is very important because LTT can now
trace a system without using any spinlocks or IRQ disabling whatsoever.
Though this feature is currently only in the 2.5.35 patch included with
LTT, it will be part of all patches for kernels past 2.5.35. At this
time, preliminary testing of the 2.5.35 patch included in 0.9.6pre1
has shown some minor issues which will result in lockups. These issues
will be addressed in a patch I will soon be releasing for 2.5.36.

This is a development release, so the usual warnings apply.

You will find 0.9.6pre1 here:
http://opersys.com/ftp/pub/LTT/

LTT's web site is here:
http://www.opersys.com/LTT

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
