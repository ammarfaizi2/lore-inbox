Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131230AbRAOUCC>; Mon, 15 Jan 2001 15:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131257AbRAOUBw>; Mon, 15 Jan 2001 15:01:52 -0500
Received: from mail.zmailer.org ([194.252.70.162]:31498 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S131230AbRAOUBh>;
	Mon, 15 Jan 2001 15:01:37 -0500
Date: Mon, 15 Jan 2001 22:01:25 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Tobias Ringstrom <tori@tellus.mine.nu>,
        David Balazic <david.balazic@uni-mb.si>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MTRR type AMD Duron/intel ?
Message-ID: <20010115220125.U25659@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.30.0101151937460.8658-100000@svea.tellus> <Pine.LNX.4.10.10101151151080.6408-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101151151080.6408-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jan 15, 2001 at 11:52:12AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2001 at 11:52:12AM -0800, Linus Torvalds wrote:
> On Mon, 15 Jan 2001, Tobias Ringstrom wrote:
> > Last time I checked this was issued for perfectly known and valid bridges
> > that advertice no IO resources.  Isn't it a bit silly to issue that
> > warning for that case, or am I missing something?
> 
> Ehh - so what do they bridge, then?
> 
> I'd say that a bridge that doesn't seem to bridge any IO or MEM region,
> yet has stuff behind it, THAT is the silly thing. Thus the "silly"
> warning.

	Like a cardbus controller without any cards in ?
	My IBM laptop reports that at the TI PCI1450 bridges,
	when I don't have anything plugged in.

> 		Linus

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
