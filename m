Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbRGBCtX>; Sun, 1 Jul 2001 22:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265797AbRGBCtM>; Sun, 1 Jul 2001 22:49:12 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:34314 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265806AbRGBCs7>; Sun, 1 Jul 2001 22:48:59 -0400
Date: Sun, 1 Jul 2001 19:47:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Removal of PG_marker scheme from 2.4.6-pre
In-Reply-To: <Pine.LNX.4.33L.0107012301460.19985-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0107011943240.7587-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Jul 2001, Rik van Riel wrote:
> > "me: undo page_launder() LRU changes, they have nasty side effects"
> >
> > Can you be more verbose about this ?
>
> I think this was fixed by the GFP_BUFFER vs. GFP_CAN_FS + GFP_CAN_IO
> thing and Linus accidentally backed out the wrong code ;)

You wish.

Except it wasn't so.

Follow the list, and read the emails that were cc'd to you.

pre2 was fine, pre3 was not.

ac12 was fine, ac13 was not.

pre3 with the pre2 page_launder was fine.

There is no question about it. The patch that caused problems was the one
that was reversed. Please stop confusing the issue.

		Linus

