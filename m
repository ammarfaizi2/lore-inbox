Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311285AbSCLQvI>; Tue, 12 Mar 2002 11:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311286AbSCLQu7>; Tue, 12 Mar 2002 11:50:59 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:34309 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311285AbSCLQur>; Tue, 12 Mar 2002 11:50:47 -0500
Date: Tue, 12 Mar 2002 17:50:44 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020312175044.A5228@ucw.cz>
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz> <3C8E28A1.1070902@evision-ventures.com> <20020312172134.A5026@ucw.cz> <3C8E2C2C.2080202@evision-ventures.com> <20020312173301.C5026@ucw.cz> <3C8E3025.4070409@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8E3025.4070409@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Mar 12, 2002 at 05:43:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 05:43:17PM +0100, Martin Dalecki wrote:
> Vojtech Pavlik wrote:
> > On Tue, Mar 12, 2002 at 05:26:20PM +0100, Martin Dalecki wrote:
> > 
> >>Vojtech Pavlik wrote:
> >>
> >>
> >>
> >>>Well, as much as I'd like to use safe pre-computed register values for
> >>>the chips, that ain't possible - even when we assumed the system bus
> >>>(PCI, VLB, whatever) was always 33 MHz, still the drives have various
> >>>ideas about what DMA and PIO modes should look like, see the tDMA and
> >>>tPIO entries in hdparm -t.  
> >>>
> >>Yes yes yes of course some of the drivers are confused. And I don't
> >>argue that precomputation is adequate right now. It just wasn't for
> >>the CMD640 those times... I only wanted to reffer to history and
> >>why my timings where different then the computed.
> >>
> > 
> > We may want to compare your original timings to what ide-timing.[ch]
> > will compute ...
> 
> Unfortunately there is no chance. I have abondony this board quite
> happy a long time ago... It was an 486 and I don't keep old
> shread around. Sorry I just don't have it at hand anylonger.

You may happen to have the numbers, though - that should be enough.

Btw, I have a CMD640B based PCI card lying around here, but never
managed to get it generate any interrupts, though the rest seems to be
working.

-- 
Vojtech Pavlik
SuSE Labs
