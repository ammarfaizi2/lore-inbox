Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136401AbRD2WWD>; Sun, 29 Apr 2001 18:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136396AbRD2WVt>; Sun, 29 Apr 2001 18:21:49 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:14055 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S136395AbRD2WVh>; Sun, 29 Apr 2001 18:21:37 -0400
Date: Sun, 29 Apr 2001 16:20:13 -0600
Message-Id: <200104292220.f3TMKDx22633@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <20010429161827.B17539@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain>
	<20010428215301.A1052@gruyere.muc.suse.de>
	<200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>
	<9cg7t7$gbt$1@cesium.transmeta.com>
	<3AEBF782.1911EDD2@mandrakesoft.com>
	<15083.64180.314190.500961@pizda.ninka.net>
	<20010429153229.L679@nightmaster.csn.tu-chemnitz.de>
	<200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca>
	<20010429221159.U706@nightmaster.csn.tu-chemnitz.de>
	<20010429161827.B17539@xi.linuxpower.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell writes:
> On Sun, Apr 29, 2001 at 10:11:59PM +0200, Ingo Oeser wrote:
> [snip]
> > The point is: The code in that "magic page" that considers the
> > tradeoff is KERNEL code, which is designed to care about such
> > trade-offs for that machine. Glibc never knows this stuff and
> > shouldn't, because it is already bloated.
> > 
> > We get the full win here, for our "compile the kernel for THIS
> > machine to get maximum performance"-strategy.
> > 
> > People tend to compile the kernel, but not the glibc.
> > 
> > Just let the benchmarks, Linus and Ulrich decide ;-)
> 
> The kernel can even customize the page at runtime if it needs to, such as
> changing algorithims to deal with lock contention.
> 
> Of course, this page will need to present a stable interface to
> glibc, and having both the code and a comprehensive jump-table might
> become tough in a single page...

Sure. IIRC, Linus talked about "a few pages".

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
