Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273846AbRJDL5J>; Thu, 4 Oct 2001 07:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273877AbRJDL47>; Thu, 4 Oct 2001 07:56:59 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:49593 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S273846AbRJDL4o>;
	Thu, 4 Oct 2001 07:56:44 -0400
Date: Thu, 4 Oct 2001 07:54:19 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Simon Kirby <sim@netnation.com>
cc: Ben Greear <greearb@candelatech.com>, Ingo Molnar <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011004014524.A1496@netnation.com>
Message-ID: <Pine.GSO.4.30.0110040751040.9341-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Oct 2001, Simon Kirby wrote:

> On Wed, Oct 03, 2001 at 09:04:22PM -0400, jamal wrote:
>
> > I think you can save yourself a lot of pain today by going to a "better
> > driver"/hardware. Switch to a tulip based board; in particular one which
> > is based on the 21143 chipset. Compile in hardware traffic control and
> > save yourself some pain.
>
> Or an Acenic-based card, but that's more expensive.
>
> The problem we had with Tulip-based cards is that it's hard to find a
> good model (variant) that is supported with different kernel versions and
> stock drivers, doesn't change internally with time, and is easily
> distinguishable by our hardware suppliers.  "Intel EtherExpress PRO100+"
> is difficult to get wrong, and there are generally less issues with
> driver compatibility because there are many fewer (no) clones, just a few
> different board revisions.  The same goes with 3COM 905/980s, etc.
>
> I'm not saying Tulips aren't better (they probably are, competition is
> good), but eepro100s are quite simple (and have been reliable for our
> servers much more than 3com 905s and other cards have been in the past).
>

Has nothing to do with specific hardware although i see your point.
send me an eepro and i'll at least add hardware flow control for you.
The API is simple, its up to the driver maintainers to use. This
discussion is good to make people aware of those drivers.

cheers,
jamal

