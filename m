Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129739AbQKARAN>; Wed, 1 Nov 2000 12:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131425AbQKARAE>; Wed, 1 Nov 2000 12:00:04 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:10227 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129739AbQKAQ7x>; Wed, 1 Nov 2000 11:59:53 -0500
Date: Wed, 1 Nov 2000 14:59:01 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Yann Dirson <ydirson@altern.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, andrea@e-mind.com
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails,
 machine hangs)
In-Reply-To: <20001101174816.A18510@athlon.random>
Message-ID: <Pine.LNX.4.21.0011011456430.11112-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Andrea Arcangeli wrote:
> On Wed, Nov 01, 2000 at 05:43:39PM +0100, Yann Dirson wrote:
> > However, the OOM killer behaves in strange ways, it seems.  In the 2 "make
> 
> Fair enough as there isn't an oom killer in the kernel you're
> running :). So it can kill unlucky tasks as well.

There's a (slightly outdated?) patch available on my home
page, though...

> Since nobody cares to implement it, for 2.4.x on my TODO list
> there's an alternative oom killer based on the task fault rate.

Cool. It will be interesting to see how this compares to my
OOM killer (and to the other approaches that will undoubtedly
surface over the next few months).

I'm definately looking forward to an "OOM killer showdown"
where we can compare how the different OOM tactics work.
Not because I think it matters all that much on most systems
(good admins put in enough memory&swap), but simply because
it appears there has been amazingly little research on this
subject and it's completely unknown which approach will work
"best" ... or even, what kind of behaviour is considered to
be best by the users...

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
