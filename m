Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135490AbRDWRz7>; Mon, 23 Apr 2001 13:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135489AbRDWRzt>; Mon, 23 Apr 2001 13:55:49 -0400
Received: from chiara.elte.hu ([157.181.150.200]:525 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135490AbRDWRzj>;
	Mon, 23 Apr 2001 13:55:39 -0400
Date: Mon, 23 Apr 2001 18:54:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Szabolcs Szakacsits <szaka@f-secure.com>
Subject: Re: [patch] swap-speedup-2.4.3-A2
In-Reply-To: <Pine.LNX.4.21.0104231011070.13206-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0104231852130.394-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Apr 2001, Linus Torvalds wrote:

> The above is NOT how the page cache works. Or if some part of the page
> cache works that way, then it is a BUG. You must NEVER allow multiple
> outstanding reads from the same location - that implies that you're
> doing something wrong, and the system is doing too much IO.

you are right, the pagecache does it correctly, i've just re-checked all
places.

	Ingo

