Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264587AbRFPGPi>; Sat, 16 Jun 2001 02:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264588AbRFPGP2>; Sat, 16 Jun 2001 02:15:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53931 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264587AbRFPGPQ>;
	Sat, 16 Jun 2001 02:15:16 -0400
Date: Sat, 16 Jun 2001 02:15:14 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andi Kleen <ak@suse.de>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac14
In-Reply-To: <oupzob9q84y.fsf@pigdrop.muc.suse.de>
Message-ID: <Pine.GSO.4.21.0106160207570.10605-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 Jun 2001, Andi Kleen wrote:

> "David S. Miller" <davem@redhat.com> writes:
> 
> > Alan Cox writes:
> >  > Because right now I dont consider the 2.4.6 page cache ext2 stuff safe
> >  > enough to merge. I'm letting someone else be the sucide squad.. so far it
> >  > looks like it is indeed fine but I want to wait and see more yet
> > 
> > If it means anything it has already withstanded a few
> > cerebus-->fsck_check-->cerebus rounds on machines here
> > in my lab.
> 
> ... it also seems to make ppc not boot anymore.

Huh? By the time when ext2 directories come into the game you are _very_
far into the boot sequence. At which stage does it fail?  Does it fail
with root on minixfs/reiserfs/etc.?

