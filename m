Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTJYRnF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 13:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbTJYRnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 13:43:05 -0400
Received: from witte.sonytel.be ([80.88.33.193]:59536 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262747AbTJYRmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 13:42:45 -0400
Date: Sat, 25 Oct 2003 19:42:28 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: bill davidsen <davidsen@tmr.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
In-Reply-To: <bnbmmf$45r$1@gatekeeper.tmr.com>
Message-ID: <Pine.GSO.4.21.0310251935390.29921-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Oct 2003, bill davidsen wrote:
> In article <20031024165553.GB933@inwind.it>,
> M. Fioretti <m.fioretti@inwind.it> wrote:
> | On Fri, Oct 24, 2003 15:59:33 at 03:59:33PM +0000, bill davidsen (davidsen@tmr.com) wrote:
> | > Agreed, until you start to talk cluster. If you pay for electricity,
> | > newer machines use less per MHz. One of those $200 "Lindows" boxen
> | > from Wal-Mart starts to look good about the 2nd old Pentium!
> | 
> | May I ask you to elaborate on this? Less per MHz doesn't matter much
> | if the frequency is much higher, or it does? I mean, if you put, say,
> | a 133 MHz pentium and a 1 GB pentium to do the same thing with the
> | same SW (mail server, for example), the 1GB system may use less per
> | MHz (newer silicon, lower voltage, etc...) and its flip-flops toggle
> | for a smaller percentage of time, but its electricity bill will still
> | be the higher one, or not?
> 
> Presumably a cluster exists to do more work than can be done on a single
> machine. So a single cheap low power modern system will probably use a
> lot less power to do equal work. Perhaps MHz was a poor choice, but we
> don't really have a good single term for an arbitrary unit of computing
> (AUC?) which is what I really meant there. At some point a cluster of

MIPS/mW, like they do for embedded CPUs?

> | In general: has anybody ever done *this* kind of benchmarks? Comparing
> | electricity consumption among different systems doing just the same
> | task?
> 
> If same task means the same number of AUC, say web pages served,
> probably you could find that somewhere. Or measure a 486, a P4 and a C3
> compiling a kernel. If the 486 takes about 80 minutes (from memory
> that's close), and a P4-2.6 takes about 8 minutes, then if the P4 takes
> less than ten times the power of the 486 it would be more efficient in
> terms of computations per watt. I have never compiled a kernel on the
> C3, but I suspect it is at least 5x the 486 and takes much less power.

The C3 is OK, I guess. But the P4 (the CPU) consumes probably about 10 times as
much power as the 486.

Of course you also have to take into account disk and RAM, etc.

Yes, MIPS/mW ratio for your desktop CPU looks very bad compared to e.g. PPC440,
StrongARM, or Vr4133...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

