Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143834AbRAHOTo>; Mon, 8 Jan 2001 09:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143836AbRAHOTe>; Mon, 8 Jan 2001 09:19:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:8091 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S143834AbRAHOTR>;
	Mon, 8 Jan 2001 09:19:17 -0500
Date: Mon, 8 Jan 2001 09:19:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stefan Traby <stefan@hello-penguin.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        drepper@gnu.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <20010108150011.A13441@stefan.sime.com>
Message-ID: <Pine.GSO.4.21.0101080903160.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Stefan Traby wrote:

> Because I have no knowledge on this I suggest that you and Ulrich fight
> together on a more flexible solution than the current one. I guess
> that Linus would accept this without thinking too much about it.

Unfortunately, Ulrich's taste was incompatible with mine in almost all
cases I can recall. So "together" is very likely to be "hand-to-hand".
glibc is hopelessly ugly. If it can be made cleaner without making
the kernel API ugly - wonderful. If not - too bad. For glibc.

IOW, if you can propose clean API - do it. If Ulrich can do that - great,
I'm more than willing to listen. I'm not holding my breath on the last
one, though.

PS: The day when Linus will really switch to accepting API changes without
thinking about them will be the day when I stop work on his tree.
So far it had not happened and I like it that way, thank you very much.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
