Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbRFBWFQ>; Sat, 2 Jun 2001 18:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbRFBWFG>; Sat, 2 Jun 2001 18:05:06 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:3596 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261771AbRFBWEu>;
	Sat, 2 Jun 2001 18:04:50 -0400
Date: Sun, 3 Jun 2001 00:04:42 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for realthis
Message-ID: <20010603000442.B1290@pcep-jamie.cern.ch>
In-Reply-To: <3B1790FB.82FC9251@mandrakesoft.com> <E155oW2-0000Ta-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E155oW2-0000Ta-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jun 01, 2001 at 01:58:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Only some of them can be cached...  (some of the MIIs in some drivers
> > are already cached, in fact)   you can't cache stuff like what your link
> > partner is advertising at the moment, or what your battery status is at
> > the moment.
> 
> I am sure that to an unpriviledged application reporting back the same result
> as we saw last time we asked the hardware unless it is over 30 seconds old
> will work fine. Maybe 10 for link partner ?

Please no, 30 seconds is way too long for "your mains power is
knackered, please fiddle with the power connector again" notification.
When I jiggle the wire I need to know if it's making contact within 1
second, and if it's lost when I let it go, I need to know that within
1 second so I can jiggle it some more.

Probably should try some contact cleaner ;-)

Thanks...
-- Jamie
