Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbTCEAS0>; Tue, 4 Mar 2003 19:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbTCEAS0>; Tue, 4 Mar 2003 19:18:26 -0500
Received: from async69.modempool.kth.se ([130.237.10.69]:2176 "EHLO
	zaphod.guide") by vger.kernel.org with ESMTP id <S265285AbTCEASZ>;
	Tue, 4 Mar 2003 19:18:25 -0500
To: linux-kernel@vger.kernel.org
Subject: ALSA misbehaving with kernel 2.4.21-pre4
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 05 Mar 2003 01:24:36 +0100
Message-ID: <yw1xsmu2k6d7.fsf@zaphod.guide>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently switched to kernel 2.4.21-pre4 from 2.4.19 (I had to
because of new hardware).  Now the timer in ALSA runs too slow.
Comparing to the system clock it drifts by about 1 second per 4
minutes, when playing sound at 48 kHz.  With lower sampling
frequencies it drifts less.  Have there been any changes in the kernel
that could explain this?  I am using alsa 0.9.0rc7 before and after
the kernel switch, I only recompiled the modules.

-- 
Måns Rullgård
mru@users.sf.net
