Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277636AbRJHXtc>; Mon, 8 Oct 2001 19:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277638AbRJHXtX>; Mon, 8 Oct 2001 19:49:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2566 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277636AbRJHXtP>; Mon, 8 Oct 2001 19:49:15 -0400
Date: Mon, 8 Oct 2001 16:48:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, <linux-xfs@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.3.96.1011009010928.13677A-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0110081647550.1064-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Oct 2001, Mikulas Patocka wrote:
>
> Linus, what do you think: is it OK if fork randomly fails with very small
> probability or not?

I've never seen it, I've never heard it reported, and I _know_ that
vmalloc() causes slowdowns.

In short, I'm not switching to a vmalloc() fork.

		Linus

