Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274883AbRIVA4q>; Fri, 21 Sep 2001 20:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274884AbRIVA4f>; Fri, 21 Sep 2001 20:56:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45062 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274883AbRIVA4a>; Fri, 21 Sep 2001 20:56:30 -0400
Date: Fri, 21 Sep 2001 17:54:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: swapoff() behaviour
In-Reply-To: <Pine.GSO.4.21.0109212046570.9760-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0109211754010.1052-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Sep 2001, Alexander Viro wrote:
>
> In other words, during the last 4 years quite a few pieces of mm/swapfile.c
> had been a dead code.  Looks like we either need to restore old behaviour
> or perform the amputation.  Snippet above is not the only place of that
> kind.
>
> Linus, it's your call.

Well, considering that it's been four years, and we haven't had a single
complaint - and that it was found now only due to code walkthrough - I
strongly suggest we just kill the code that can't be reached and has no
meaning.

		Linus

