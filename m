Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131600AbRCXH3a>; Sat, 24 Mar 2001 02:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131603AbRCXH3U>; Sat, 24 Mar 2001 02:29:20 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:57105 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131600AbRCXH3K>; Sat, 24 Mar 2001 02:29:10 -0500
Date: Sat, 24 Mar 2001 03:58:24 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <l03130311b6e19132f3bf@[192.168.239.101]>
Message-ID: <Pine.LNX.4.21.0103240355560.1863-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2001, Jonathan Morton wrote:

> Hmm...  "if ( freemem < (size_of_mallocing_process / 20) ) fail_to_allocate;"
> 
> Seems like a reasonable soft limit - processes which have already got
> lots of RAM can probably stand not to have that little bit more and
> can be curbed more quickly.

This looks like it could nicely in preventing a single process
from getting out of hand and gobbling up all memory.

It won't prevent the system from a mongolian horde of processes,
but nobody should expect your one-liner to fix world piece ;)

I like it, now lets test it ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

