Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLOUkT>; Fri, 15 Dec 2000 15:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131241AbQLOUkJ>; Fri, 15 Dec 2000 15:40:09 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:49396 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129340AbQLOUkC>; Fri, 15 Dec 2000 15:40:02 -0500
Date: Fri, 15 Dec 2000 18:09:16 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ulrich Drepper <drepper@cygnus.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
In-Reply-To: <20001215205721.I17781@inspiron.random>
Message-ID: <Pine.LNX.4.21.0012151808540.3596-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2000, Andrea Arcangeli wrote:

> And yes I can see that the whole point of the change is that
> they want to also forbids this:
> 
> x()
> {
> 	goto out;
> out:
> }
> 
> and I dislike not being allowed to do the above as well infact ;).

What's wrong with the - more readable - `break;' ?

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
