Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTLDS40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbTLDS40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:56:26 -0500
Received: from mxsf13.cluster1.charter.net ([209.225.28.213]:32266 "EHLO
	mxsf13.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S263531AbTLDS4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:56:24 -0500
Date: Thu, 4 Dec 2003 12:55:48 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Message-ID: <20031204175548.GB10471@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3FCF25F2.6060008@netzentry.com> <1070551149.4063.8.camel@athlonxp.bradney.info> <20031204163243.GA10471@forming> <frodoid.frodo.87vfow33zm.fsf@usenet.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <frodoid.frodo.87vfow33zm.fsf@usenet.frodoid.org>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test11-Jm i686
X-Uptime: 11:23:23 up 19:49,  9 users,  load average: 0.18, 0.42, 3.20
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Thu, Dec 04, 2003 at 06:08:29PM +0100, Julien Oster wrote:
> Josh McKinney <forming@charter.net> writes:
> 
> Hello Josh,
> 
> > Just to add more inconsistency into the mix, I am running with preempt
> > enabled, generic ide disabled, and can't make it crash.  Ran netperf for
> > an hour over a crossover cable on 100mbit, a couple make -j 30 kernel
> > compiles, dbench, and playing some mp3's all at the same time and
> > nothing happens despite load average reaching over 100.  Maybe I am just
> > lucky.
> 
> Or maybe not.
> 
> In the very beginning, 1 or 2 months ago right after I bought the
> board, it did crash but it actually didn't crash very often. In fact,
> most of the time (not every time, but most!) it crashed while the
> system being rather idle. To add even more perplexity to it: I could
> work on the system for hours and then leave the computer half an hour
> alone for talking a walk or jogging or whatever and, after coming
> back, run across a complete lockup. Normally, the clock applet on my
> desktop told me that the box crashed several minutes after I went out,
> since the clock of course froze with the mainboard as well.
> 
> A lot changed by now, hardware and software, and now I'm hardly able
> to run the system with ACPI/APIC enabled at all. If the boot procedure
> goes fine, it locks up shortly after. If fsck decides to check the
> disks, the mainboard is doomed to lock up away immediately.
> 
> That really is a nasty problem.
> 

This issue seems to be funny like that.  When I first recieved this
mobo I too had crashes like you say you are having now.  Doing
practically anything would make it crash, passing noapic and nolapic
on boot solved the problems.  Now, as I said, stable with all ACPI
APIC LAPIC enabled.  I haven't changed any hardware or anything
either, except for now I am using the nvidia ethernet with the
forcedeth driver, but I somehow don't think that has anything to do
with it, maybe it is worth looking into. 

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
