Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSE2RFe>; Wed, 29 May 2002 13:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSE2RFd>; Wed, 29 May 2002 13:05:33 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:38800 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313867AbSE2RFc>;
	Wed, 29 May 2002 13:05:32 -0400
Date: Wed, 29 May 2002 19:05:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Gerald Champagne <gerald@io.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73
Message-ID: <20020529190517.A19854@ucw.cz>
In-Reply-To: <1022680784.2945.24.camel@wiley> <3CF4D19F.9080402@evision-ventures.com> <20020529183343.A19610@ucw.cz> <1022694938.9255.269.camel@irongate.swansea.linux.org.uk> <20020529190135.A19776@ucw.cz> <3CF4FC52.7080406@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 06:05:38PM +0200, Martin Dalecki wrote:
> Vojtech Pavlik wrote:
> > On Wed, May 29, 2002 at 06:55:38PM +0100, Alan Cox wrote:
> > 
> > 
> >>>Also for black/whitelists. And we're going to need those, though maybe
> >>>the current data in them is not worth much.
> >>
> >>I'm hopeful they still are. The early drives with DMA problems won't
> >>have changed over time, and I've been updating the others when I get
> >>data from vendors. Promise for example recently sent me a couple to add
> > 
> > 
> > The early drives haven't changed, but the drivers for the controllers
> > which they were tested on changed (or will change soon). Namely the
> > lists of PIO mode limits were wrong very often. This is mainly because
> > some of the (now almost unused) drivers program the timings incorrectly
> > into the controller registers.
> > 
> > I can't say much about the more recent entries, except for that it'd be
> > nice to add a date when the entry was last tested and with what result
> > to each of them over time.
> 
> And plese note as well that we don't need the whole id struct, but just
> the name of the drive as well. Which is much less of a hassle anyway.

Correct. And the manufacturer and the revision.

-- 
Vojtech Pavlik
SuSE Labs
