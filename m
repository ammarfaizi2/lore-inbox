Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268510AbRHFNXR>; Mon, 6 Aug 2001 09:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268514AbRHFNXH>; Mon, 6 Aug 2001 09:23:07 -0400
Received: from Expansa.sns.it ([192.167.206.189]:11524 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S268510AbRHFNWt>;
	Mon, 6 Aug 2001 09:22:49 -0400
Date: Mon, 6 Aug 2001 15:22:32 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <jlnance@intrex.net>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <20010803090703.B1248@bessie.localdomain>
Message-ID: <Pine.LNX.4.33.0108061521280.4694-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with 2.4.5 i had similar problems with 4 GB RAM on a 4-processor
sparc64.
2.4.6 solved my problems.

On Fri, 3 Aug 2001 jlnance@intrex.net wrote:

> On Thu, Aug 02, 2001 at 07:27:42PM -0300, Rik van Riel wrote:
> > On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:
> >
> > > I'm telling you that's not what happens.  When memory pressure
> > > gets really high, the kernel takes all the CPU time and the box
> > > is completely useless. Maybe the VM sorts itself out but after
> > > five minutes of barely responding, I usually just power cycle
> > > the damn thing.  As I said, this isn't a classic thrash because
> > > the swap disks only blip perhaps once every ten seconds!
> >
> > What kind of workload are you running ?
> >
> > We could be dealing with some weird artifact of
> > virtual page scanning here, or with a strange
> > side effect of recent VM changes ...
>
> Rik,
>     FWIW, I am seeing this sort of thing too, though I am running a 2.4.5
> kernel so I am a little out of date.  Its a large machine with 2G of ram,
> 4G of swap, and 2 CPUs.  You dont have to actually use all the memory either.
> When my process gets to about 1.5G and starts doing lots of file I/O, the
> machine can just disappear for several minutes.  I will be sshed in and
> I can not even get my shell to give me a new prompt when I hit return.  It
> will eventually sort it self out, but it might take 15 minutes.  I will try
> and get a more recent kernel installed, but the machine is not under my
> control, so I dont get to decide when that happens.
>
> Thanks,
>
> Jim
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

