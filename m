Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRACXKS>; Wed, 3 Jan 2001 18:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRACXKI>; Wed, 3 Jan 2001 18:10:08 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:51186 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131400AbRACXKA>; Wed, 3 Jan 2001 18:10:00 -0500
Date: Wed, 3 Jan 2001 21:09:01 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
In-Reply-To: <20010103221221.I32185@athlon.random>
Message-ID: <Pine.LNX.4.21.0101032107550.1917-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Andrea Arcangeli wrote:
> On Wed, Jan 03, 2001 at 05:47:39PM -0200, Rik van Riel wrote:
> > Not really. Under very high VFS loads we'd just scan
> > through the list twice and free the entries anyway.
> 
> You're obviously wrong.
> 
> The higher was the load, the faster your working set was getting
> dropped from the dcache. (with the patch the working set will
> have a chance to remains in cache also with polluting going on
> instead,

> The example with only pollution in the cache doesn't make sense,

Ever heard of slocate / updatedb ?

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
