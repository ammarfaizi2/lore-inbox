Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131149AbQK1Njy>; Tue, 28 Nov 2000 08:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131199AbQK1Njp>; Tue, 28 Nov 2000 08:39:45 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:15426 "EHLO
        twilight.cs.hut.fi") by vger.kernel.org with ESMTP
        id <S131149AbQK1Nje>; Tue, 28 Nov 2000 08:39:34 -0500
Date: Tue, 28 Nov 2000 15:09:11 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre19 oops in try_to_free_pages
Message-ID: <20001128150911.P53529@niksula.cs.hut.fi>
In-Reply-To: <20001128145229.O53529@niksula.cs.hut.fi> <E140kKf-0004U3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E140kKf-0004U3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 28, 2000 at 12:57:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 12:57:59PM +0000, you [Alan Cox] claimed:
> > I wasn't the one who used cdrom, so it is possible, that the person in
> > question had been able to eject the cd without unmounting it first. I'll
> > check if the door locking on that device works.
> 
> Also rpm -e magicdev --nodeps if magicdev is on the box.

Oops. Seems that there was one. Looks like I did not check the system well
enough after rh70 install...

> > But you are certain that the oops was eventually caused by these and not
> > by any bug in vm?
> 
> This one . Yes.

Ok, good. So avoiding ejecting cdrom without unmounting first will save me
from further oopses.

> The VM layer isnt causing any oopses I've seen in 2.2.17+. It doesn't always
> make good choices and Rik or Andrea's stuff is on the list after 2.2.18

Yes. The other problem I saw with 2.2.18pre vm wasn't an oops, it was a
rampaging vm rambo that slaughtered my X while it was idle. Admittedly
that is not as severe as oops, so the vm situation is not as bad as I
thought.

> (I refuse to mix VM changes with the big driver changes)

No problem. 

 
-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
