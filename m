Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTLDRIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 12:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTLDRId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 12:08:33 -0500
Received: from ppp-62-245-209-38.mnet-online.de ([62.245.209.38]:55449 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S263267AbTLDRIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 12:08:31 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <3FCF25F2.6060008@netzentry.com>
	<1070551149.4063.8.camel@athlonxp.bradney.info>
	<20031204163243.GA10471@forming>
From: Julien Oster <lkml-2412@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Thu, 04 Dec 2003 18:08:29 +0100
In-Reply-To: <20031204163243.GA10471@forming> (Josh McKinney's message of
 "Thu, 4 Dec 2003 11:32:43 -0500")
Message-ID: <frodoid.frodo.87vfow33zm.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh McKinney <forming@charter.net> writes:

Hello Josh,

> Just to add more inconsistency into the mix, I am running with preempt
> enabled, generic ide disabled, and can't make it crash.  Ran netperf for
> an hour over a crossover cable on 100mbit, a couple make -j 30 kernel
> compiles, dbench, and playing some mp3's all at the same time and
> nothing happens despite load average reaching over 100.  Maybe I am just
> lucky.

Or maybe not.

In the very beginning, 1 or 2 months ago right after I bought the
board, it did crash but it actually didn't crash very often. In fact,
most of the time (not every time, but most!) it crashed while the
system being rather idle. To add even more perplexity to it: I could
work on the system for hours and then leave the computer half an hour
alone for talking a walk or jogging or whatever and, after coming
back, run across a complete lockup. Normally, the clock applet on my
desktop told me that the box crashed several minutes after I went out,
since the clock of course froze with the mainboard as well.

A lot changed by now, hardware and software, and now I'm hardly able
to run the system with ACPI/APIC enabled at all. If the boot procedure
goes fine, it locks up shortly after. If fsck decides to check the
disks, the mainboard is doomed to lock up away immediately.

That really is a nasty problem.

Regards,
Julien
