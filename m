Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317318AbSFCIy4>; Mon, 3 Jun 2002 04:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317317AbSFCIyz>; Mon, 3 Jun 2002 04:54:55 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:63106 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317318AbSFCIyy>;
	Mon, 3 Jun 2002 04:54:54 -0400
Date: Mon, 3 Jun 2002 10:47:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Anthony Spinillo <tspinillo@linuxmail.org>,
        linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
Message-ID: <20020603104747.C13158@ucw.cz>
In-Reply-To: <20020602101628.4230.qmail@linuxmail.org> <3CFA73C3.9010902@evision-ventures.com> <20020602233043.A11698@ucw.cz> <3CFAF4A0.5010702@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 06:46:24AM +0200, Martin Dalecki wrote:
> Vojtech Pavlik wrote:
> > On Sun, Jun 02, 2002 at 09:36:35PM +0200, Martin Dalecki wrote:
> > 
> >>Anthony Spinillo wrote:
> >>
> >>>Back to my original problem, will there be a fix before 2010? ;)
> >>
> >>Well since you have already tyred yourself to poke at it.
> >>Well please just go ahead and atd an entry to the table
> >>at the end of piix.c which encompasses the device.
> >>Do it by copying over the next familiar one and I would
> >>be really geald if you could just test whatever this
> >>worked. If yes well please send me just the patch and
> >>I will include it.
> > 
> > 
> > Note it works with 2.5 already. We have the device there.
> 
> Yes after looking it up I realized it's already there.

But as Alan pointer out, in 2.4 the missing PCI ID isn't the problem -
it would work with no tuning without it, but the fact the on-board BIOS
incorrectly assigns io-ranges to the PCI device is a problem we may have
on 2.5 as well.

-- 
Vojtech Pavlik
SuSE Labs
