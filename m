Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280190AbRLWVEt>; Sun, 23 Dec 2001 16:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280426AbRLWVE3>; Sun, 23 Dec 2001 16:04:29 -0500
Received: from Makaera.com ([199.202.113.33]:3589 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id <S280190AbRLWVEV>;
	Sun, 23 Dec 2001 16:04:21 -0500
Date: Sun, 23 Dec 2001 16:04:19 -0500
From: really mason_at_soo_dot_com <lnx-kern@Sophia.soo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 oddness under X
Message-ID: <20011223160419.A22752@Sophia.soo.com>
In-Reply-To: <20011223144800.A22538@Sophia.soo.com> <Pine.LNX.4.33.0112231457070.5312-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112231457070.5312-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Sun, Dec 23, 2001 at 02:58:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vojtech and Mark, this is good to know and gives
me more confidence messing around with this box... er,
not that i'd stop in any case...

On Sun, Dec 23, 2001 at 08:53:14PM +0100, Vojtech Pavlik wrote:
> Good, then. In theory your IDE should operate well if you did this,
> eventhough you run the 37 MHz PCI. Other devices may not like this
> still, though.
>
> > i thot it
> > was only relevant to PIO modes?  Shows how little i
> > know abt the IDE drivers.
>
> It is relevant to all PIO, DMA and UDMA modes.

The funny thing still is that i get this error regardless
of whether i overclock, underclock, or leave as is using
kernel 2.5.2-pre1, when i start X:

Inconsistency detected by ld.so: dynamic-link.h: 62: elf_get_dynamic_info: Assertion `! "bad dynamic tag"' failed!

X eventually starts, minus the Sawfish window manager.

Everything's fine from kernel version 2.5.1 down.  If it
is indeed disk corruption of some kind, i guess i better 
run an older kernel and fsck.

On Sun, Dec 23, 2001 at 02:58:38PM -0500, Mark Hahn wrote:
> overclocking is always invalid.  some software is generous
> enough to let you actually compensate for you botching the config.
> in this case, the driver *must* have the actual PCI clock,
> since the ide timings are derived from it (and *not* overclockable).
>
> otoh, you're overclocking, therefore don't mind bogosity,
> so probably *want* overclocked ide timings.

b

