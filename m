Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267082AbRGJSsG>; Tue, 10 Jul 2001 14:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbRGJSrr>; Tue, 10 Jul 2001 14:47:47 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38925 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267082AbRGJSri>; Tue, 10 Jul 2001 14:47:38 -0400
Date: Tue, 10 Jul 2001 11:46:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <20010710165637.B15734@athlon.random>
Message-ID: <Pine.LNX.4.33.0107101144520.11830-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jul 2001, Andrea Arcangeli wrote:
>
> another issue is that I don't see any value in defining the
> unlock_buffer() with the get_bh/put_bh in it.

Ahh, I forgot about that.

That's just a remnant of my original fix (which looked very much like
yours, and had the same bug), and I just hadn't cleaned up after I did the
real fix. Thanks for reminding me - done.

I also did the end_buffer_io_sync() cleanup.

		Linus

