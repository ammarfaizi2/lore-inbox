Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbSKZPgb>; Tue, 26 Nov 2002 10:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266369AbSKZPgb>; Tue, 26 Nov 2002 10:36:31 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:46554
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266367AbSKZPga>; Tue, 26 Nov 2002 10:36:30 -0500
Date: Tue, 26 Nov 2002 10:47:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Joseph Fannin <jhf@rivenstone.net>
cc: Shawn Starr <spstarr@sh0n.net>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM][SOUND][2.5] - ALSA & OSS cannot find SBAWE32 Card
In-Reply-To: <20021126085840.GA1033@zion.rivenstone.net>
Message-ID: <Pine.LNX.4.50.0211261044070.1462-100000@montezuma.mastecende.com>
References: <200211260258.05564.spstarr@sh0n.net> <20021126085840.GA1033@zion.rivenstone.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Joseph Fannin wrote:

> On Tue, Nov 26, 2002 at 02:58:05AM -0500, Shawn Starr wrote:
>
> > ALSA device list:
> >    No soundcards found.
> >
> > dmesg 2.4.20-pre7 - OSS: - WORKS
> > ============================
>
>     Me too!
>
>     In 2.5.47 mainline and 2.5.49-ac1 the ALSA drivers (either sb16 or
> sbawe) load but don't detect devices if PNP support is built in.  The
> same card (an awe64) works fine under 2.4.19.
>
>     Without PNP sb16 works (with only sb16 features) but sbawe will
> not load, complaining that it can't find the awe bits.

My guess would be the new isapnp registration layer, which ALSA
doesn't seem to be using. I might have a go at it later, looks like it
might need conversion.

Cheers,
	Zwane

-- 
function.linuxpower.ca
