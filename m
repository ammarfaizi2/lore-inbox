Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310401AbSCAKVY>; Fri, 1 Mar 2002 05:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310391AbSCAKTO>; Fri, 1 Mar 2002 05:19:14 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:31242 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S310429AbSCAKRP>; Fri, 1 Mar 2002 05:17:15 -0500
Date: Fri, 1 Mar 2002 11:17:08 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <Pine.LNX.3.96.1020228221750.3310D-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0203011054370.21300-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Bill Davidsen wrote:

> On Thu, 28 Feb 2002, Mike Fedyk wrote:
> 
> > The problem here is that currently the mainline kernel makes some bad
> > dicesions in the VM, and -aa is the solution in this case.  When -aa is
> > merged, you will still have both solutions; one in mainline, one as a patch
> > (rmap).
> > 
> > Linus has already changed the VM once in 2.4, and I don't really see another
> > large VM change (rmap in 2.4) happening again.
> > 
> > Rmap looks promising for a 2.5 merge after several issues are overcome
> > (pte-highmem, etc).
> 
> I do understand what happens in the VM currently... And as noted I run
> both -aa kernels and rmap on different machines. But -aa runs better on
> large machines and rmap better on small machines with memory pressure (my
> experience), so blessing one and making the other "only a patch" troubles
> me somewhat. I hate to say "compete" as VM solution, but they both solve
> the same problem with more success in one field or another.

2.4 VM is Andrea's. There's no competition. I see current -aa VM patches 
just as maintainance, which is performed outside the mainline for good
reasons.  As soon as Andrea is satisfied with testing, -aa will be 
integrated into Marcelo's 2.4. This is just part of VM (which admittedly
was quite "young" when it was included) maintainance/evolution.

OTOH, Red Hat 2.4 kernels are still based on Rik's, AFAIK. I bet they'll
be running 2.4-rmap sooner or later. Red Hat has a long history of running
kernels with non standard features (RAID 0.90 comes to mind). So maybe
there *is* competition, but on the vendor side only. I do hope vanilla
2.4 VM will be -aa forever (but I'll be running RH provided kernels most
of the times - I like them).

.TM.

