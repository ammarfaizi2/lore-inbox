Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130916AbRAOTxN>; Mon, 15 Jan 2001 14:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130878AbRAOTxD>; Mon, 15 Jan 2001 14:53:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37390 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131056AbRAOTwp>; Mon, 15 Jan 2001 14:52:45 -0500
Date: Mon, 15 Jan 2001 11:52:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tobias Ringstrom <tori@tellus.mine.nu>
cc: David Balazic <david.balazic@uni-mb.si>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MTRR type AMD Duron/intel ?
In-Reply-To: <Pine.LNX.4.30.0101151937460.8658-100000@svea.tellus>
Message-ID: <Pine.LNX.4.10.10101151151080.6408-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Jan 2001, Tobias Ringstrom wrote:
> 
> Last time I checked this was issued for perfectly known and valid bridges
> that advertice no IO resources.  Isn't it a bit silly to issue that
> warning for that case, or am I missing something?

Ehh - so what do they bridge, then?

I'd say that a bridge that doesn't seem to bridge any IO or MEM region,
yet has stuff behind it, THAT is the silly thing. Thus the "silly"
warning.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
