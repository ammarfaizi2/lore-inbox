Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262349AbSI1X4K>; Sat, 28 Sep 2002 19:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262351AbSI1X4K>; Sat, 28 Sep 2002 19:56:10 -0400
Received: from mail.eskimo.com ([204.122.16.4]:26374 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S262349AbSI1X4I>;
	Sat, 28 Sep 2002 19:56:08 -0400
Date: Sat, 28 Sep 2002 17:00:57 -0700
To: Michael Clark <michael@metaparadigm.com>
Cc: felix.seeger@gmx.de, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: System very unstable
Message-ID: <20020929000056.GB19765@eskimo.com>
References: <200209281155.32668.felix.seeger@gmx.de> <20020928.025900.58828001.davem@redhat.com> <200209281233.21897.felix.seeger@gmx.de> <20020928.033510.40857147.davem@redhat.com> <3D958EF5.7080300@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D958EF5.7080300@metaparadigm.com>
User-Agent: Mutt/1.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 07:13:57PM +0800, Michael Clark wrote:
> On 09/28/02 18:35, David S. Miller wrote:
> >   From: Felix Seeger <felix.seeger@gmx.de>
> >   Date: Sat, 28 Sep 2002 12:33:21 +0200
> >   
> >   What card is good (performance for games and 
> >   a acceptable licenze for kernel developers)?
> >
> >ATI Radeon is pretty fast and all except the very latest chips have
> >opensource drivers.
> 
> Radeon 7500 is currently the fastest board with an opensource
> driver that supports 3D. 8500 XFree support is currently 2D only,
> although apparently work on the opensource GL driver is underway.

Unfortunately, in my experience the open source Radeon 7500 drivers are
so unstable as to be basically unusable.  Plus, they seem to still be
basically incompatible with a lot of 3d software.

I tried to get them to work for about 3 months this year, but finally
gave up when it became clear that I'd need to buy another computer, put
the Radeon in it, and start debugging the Radeon driver myself to get it
working (lest you get the wrong impression, I mean here that I'd have to
do it myself because other people seemed to be seeing them crash
somewhat less often than I did, thus I had the best repro.  Plus, to get
particular software to work, I'd have to trace it myself since other
people wouldn't have it)  Which would mean, I'd still need to buy a
graphics card to use in the meantime for my real machine.  Not being
able to justify the expense of a new, identical computer, I decided to
simply buy the graphics card and forego debugging the Radeon for the
time being.  I know, I'm a wuss.

The only reasonable option seemed to be to replace it with an NVidia
card, which has turned out to be about five orders of magnitude more
stable than the Radeon was even with the horrible closed-source NVidia
drivers.  (The MTBF for the Radeon was about 12 seconds, for the NVidia,
it seems to be about 3 days)

On the other hand, my old Matrox G400 card had stable open source
drivers which didn't appear to crash at all, so if stability is most
important, I'd say go with one of those.  Unfortunately, the card itself
is rather slow.  (Though strangely enough, in realistic tests, it was
pretty much equal or better than the Radeon...  For the short time the
Radeon could go without hard-locking the computer, that is.  This was
partly because the rendering quality was so much better, the Radeon had
to be run in 32 bit mode to compare with 16-bit rendering on the Matrox
in terms of output.)

If you need to avoid NVidia, I'd say go for a Matrox G400, or maybe some
sort of older Radeon which might be more stable.

-J
