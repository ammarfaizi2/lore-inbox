Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIC6i>; Mon, 8 Jan 2001 21:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbRAIC63>; Mon, 8 Jan 2001 21:58:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8200 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129383AbRAIC6S>; Mon, 8 Jan 2001 21:58:18 -0500
Date: Mon, 8 Jan 2001 18:58:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <87n1d1mx2d.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.10.10101081856390.1371-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Jan 2001, Zlatko Calusic wrote:
> 
> Yes, but a lot more data on the swap also means degraded performance,
> because the disk head has to seek around in the much bigger area. Are
> you sure this is all OK?

Yes and no.

I'm not _sure_, obviously.

However, one thing I _am_ sure of is that the sticky page-cache simplifies
some things enormously, and make some things possible that simply weren't
possible before. 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
