Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131384AbRAERvk>; Fri, 5 Jan 2001 12:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132135AbRAERvc>; Fri, 5 Jan 2001 12:51:32 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:19445 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131384AbRAERuy>; Fri, 5 Jan 2001 12:50:54 -0500
Date: Fri, 5 Jan 2001 15:50:30 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: MM/VM todo list
In-Reply-To: <Pine.LNX.4.21.0101051344270.2745-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101051549340.1295-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Marcelo Tosatti wrote:
> On Fri, 5 Jan 2001, Rik van Riel wrote:
> 
> > here is a TODO list for the memory management area of the
> > Linux kernel, with both trivial things that could be done
> > for later 2.4 releases and more complex things that really
> > have to be 2.5 things.
> > 
> > Most of these can be found on http://linux24.sourceforge.net/ too
> > 
> > Trivial stuff:
> > * VM: better IO clustering for swap (and filesystem) IO
> >   * Marcelo's swapin/out clustering code
>     * Swap space preallocation at try_to_swap_out()
> 
> >   * ->writepage() IO clustering support
> 
> Hum, IMO this should be in the "2.5" list because 

The non-trivial part of improved IO clustering should be a
2.5 thing indeed, but I'm not convinced there aren't any
trivial things left which can give us a nice improvement
now (and for the whole 2.4 series).

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
