Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRAEVWB>; Fri, 5 Jan 2001 16:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130393AbRAEVVw>; Fri, 5 Jan 2001 16:21:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:6649 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129747AbRAEVVn>; Fri, 5 Jan 2001 16:21:43 -0500
Date: Fri, 5 Jan 2001 19:20:24 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Christoph Hellwig <hch@caldera.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: MM/VM todo list
In-Reply-To: <20010105221326.A10112@caldera.de>
Message-ID: <Pine.LNX.4.21.0101051918550.1295-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Christoph Hellwig wrote:
> On Fri, Jan 05, 2001 at 02:56:40PM -0200, Marcelo Tosatti wrote:
> > > * VM: experiment with different active lists / aging pages
> > >   of different ages at different rates + other page replacement
> > >   improvements
> > > * VM: Quality of Service / fairness / ... improvements
> >   * VM: Use kiobuf IO in VM instead buffer_head IO. 
> 
> I'd vote for killing both bufer_head and kiobuf from VM.
> Lokk at my pageio patch - VM doesn't know about the use of kiobufs
> in the filesystem IO...

Could be interesting ... but is it generalised enough to
also work with eg. network IO ?

I won't kill this TODO item until I understand what exactly
you want to achieve and why it would be a good thing (and
until there is some kind of agreement about this idea).

Btw,
	http://www.linux.eu.org/Linux-MM/todo.shtml

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
