Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267946AbRG0Nf4>; Fri, 27 Jul 2001 09:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267950AbRG0Nfq>; Fri, 27 Jul 2001 09:35:46 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:62731 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S267946AbRG0Nfg>; Fri, 27 Jul 2001 09:35:36 -0400
From: bvermeul@devel.blackstar.nl
Date: Fri, 27 Jul 2001 15:38:24 +0200 (CEST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Hans Reiser <reiser@namesys.com>, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Steve Kieu <haiquy@yahoo.com>,
        Sam Thompson <samuelt@cervantes.dabney.caltech.edu>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q7eW-0005cP-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0107271533330.10602-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001, Alan Cox wrote:

> > > and when that hangs the kernel it will also screw up all files touched
> > > just before it in a edit-make-install-try cycle. Which can be rather
> > > annoying, because you can start all over again (this effect randomly
> > > distributes the last touched sectors to the last touched files. Very nice
> > > effect, but not something I expect from a journalled filesystem).
> > >
> > Do you think it is reasonable to ask that a filesystem be designed to
> > work well with bad drivers?
>
> Its certainly a good idea. But it sounds to me like he is describing the
> normal effect of metadata only logging.
>
> Putting a sync just before the insmod when developing new drivers is a good
> idea btw

I've been doing that most of the time. But I sometimes forget that.
But as I said, it's not something I expected from a journalled filesystem.

Regards,

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

