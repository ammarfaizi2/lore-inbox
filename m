Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277629AbRJHXrC>; Mon, 8 Oct 2001 19:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277627AbRJHXqw>; Mon, 8 Oct 2001 19:46:52 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:47366 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277629AbRJHXqh>; Mon, 8 Oct 2001 19:46:37 -0400
Date: Tue, 9 Oct 2001 01:46:52 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: torvalds@transmeta.com, Rik van Riel <riel@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <E15qk40-0002Jf-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1011009014458.15573A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Alan Cox wrote:

> > Linus, what do you think: is it OK if fork randomly fails with very small
> > probability or not?
> 
> Your code doesnt change that behaviour. Not one iota. Do the mathematics,
> work out the failure probabilities for page pairs. Now remember that the
> vmalloc one has guard pages too.
> 
> You are trying to solve a non problem with a non solution

I asked Linus, not you :-/

It's up to him, if he wants "stability-based-on-probability" algorithms in
Linux or not.

Mikulas

