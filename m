Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268634AbUH3RV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268634AbUH3RV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268598AbUH3RUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:20:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:52870 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268582AbUH3RRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:17:53 -0400
Date: Mon, 30 Aug 2004 13:17:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Arthur Perry <kernel@linuxfarms.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Celistica with AMD chip-set
In-Reply-To: <Pine.LNX.4.58.0408301052030.23343@tiamat.perryconsulting.net>
Message-ID: <Pine.LNX.4.53.0408301306020.22149@chaos>
References: <Pine.LNX.4.53.0408300955470.21607@chaos>
 <1093871709.30082.11.camel@localhost.localdomain>
 <Pine.LNX.4.58.0408301052030.23343@tiamat.perryconsulting.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004, Arthur Perry wrote:

> Hello Alan and Richard,
>
> I have to advise caution here, as it is currently unconfirmed whether or
> not the PCI bridge configuration is "incorrect", and that it has "very
> poor PCI performance".

The crapiest 33MHz, 32-bit PCI/Bus in lowly '486 machines hanging
around the lab will beat the Celistia hands-down.

> Unless everyone in the whole wide world is setting this value and we are
> the only ones who are not, I find it hard to believe that this statement
> is not overspeculative.
>

Really?  Well somebody from Salem New Hampshire wrote email to
one of my zillions of managers claiming that this was the "fix".

I was forced to make this "fix" and it "fixed" it. Further,
every "^!&@*$%^!_*(@" so called software, hardware, and whatever
"Engineer......" If that's the correct word, required (demanded)
to see the source code because they were "sure" that " had screwed
up.

To date, there has been no such finding of screw-ups on my part.
FYI, it's really difficult to screw up a "(@#%^P_*!@&#" DMA!

Other machines are able to DMA at over 130 megabytes/second. The
boxes in question run at only 50 megabytes/second.

> The proper place for this should be in the BIOS, if it is indeed a true
> optimization point.
> But until that is positively identified, we should not assume that
> applying this globally for everyone is the right thing to do.
> As in any assumed optimization for a simgle case, it could potentially
> cause performance degradation in somebody else's HBA.
>

Not so.

> This is a cache optimization.
>
> Have you considered the possibility of this "optimization" causing a
> performance hit with Mellanox's PCI implementation?
>

I published a "fix" for the abysimal PCI performance on that
piece of crap. If you don't like it then so what. Fix the
damn box.

> What about people who have already tailored their device driver to work
> well in on this chipset and currently use "read multiple" rather than
> "read cacheline". This optimization could potentially cause a slight
> degradation of performance for them.
>

I don't give a damn.  The box has no DMA capability as it is.
One might as well just use a wet string top communicate with
the PCI boards. The "fix" forced upon me by you guys is now
somehow incorrect?

Go to hell.

>
> Arthur Perry
> Linux Systems/Software Architect
> Lead Linux Engineer
> CSU Validation Group
> Celestica, Salem, NH
> aperry@celestica.com
>


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

