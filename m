Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129233AbQJaQMJ>; Tue, 31 Oct 2000 11:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129337AbQJaQL5>; Tue, 31 Oct 2000 11:11:57 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:64238 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129233AbQJaQLt>; Tue, 31 Oct 2000 11:11:49 -0500
Date: Tue, 31 Oct 2000 14:11:24 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: kmalloc() allocation.
In-Reply-To: <20001031161753.F7204@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.21.0010311410440.23139-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Ingo Oeser wrote:
> On Tue, Oct 31, 2000 at 11:35:46AM -0200, Rik van Riel wrote:
> > > Rik: What do you think about this (physical cont. area cache) for 2.5?
>                                        ^^^^^^^^^^^^^^^^^^^^^^^^^ == PCAC
> > 
> > http://www.surriel.com/zone-alloc.html
> 
> Read it when you published it first, but didn't notice you still
> worked on it ;-)
> 
> My approach is still different. We get the HINT for free. And
> your zone only shift this problem from page to mem_zone level.

It's a nice idea, but you still want to be sure you won't
allocate eg. page tables randomly in the middle of the
PCACs ;)

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
