Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272034AbRHVP4W>; Wed, 22 Aug 2001 11:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272037AbRHVP4M>; Wed, 22 Aug 2001 11:56:12 -0400
Received: from beppo.feral.com ([192.67.166.79]:53519 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S272034AbRHVP4D>;
	Wed, 22 Aug 2001 11:56:03 -0400
Date: Wed, 22 Aug 2001 08:55:43 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: Jes Sorensen <jes@sunsite.dk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ricky Beam <jfbeam@bluetopia.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <d3r8u4me0u.fsf@lxplus050.cern.ch>
Message-ID: <20010822084231.H2189-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>>>> "Matthew" == Matthew Jacob <mjacob@feral.com> writes:
>
> Matthew> It's not just a question of having firmware updated into
> Matthew> flash- which, btw, companies like Veritas have shied away
> Matthew> from getting custoemrs to do because you *do* have a small
> Matthew> but finite amount of risk updating flash. It's also code that
> Matthew> as yet has to be written for qlogicfc (e.g.) that would pull
> Matthew> it *out* of flash so it can be pushed into SRAM (which is
> Matthew> what the BIOS code on other platforms do).
>
> Yeah vendors tend to like this idea, it's not just Veritas and QLogic
> who went down this path, unfortunately.
>
> Updating the flash does seem very easy, and the good thing about the QLA
> adapters is that you can reflash even if you screwed up in the first
> place. Yup I tried that ;) Writing the flash utility seems like a piece of
> cake in this as well. What doesn't look as easy is to figure out that
> directory structure of the firmware images ;-( Any chance you got some
> data on that?

There are x86 utilities from Qlogic to *write* the flash. Reading the flash
isn't that hard itself. There is no documentation as to flash layout. Older
versions of the Linux driver say where they keep a copy of the current target
to WWN mapping in flash (which is a 'maybe not so bright' idea).

We could ask them where it is.

-matt



