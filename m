Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263070AbSJFByx>; Sat, 5 Oct 2002 21:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263108AbSJFByx>; Sat, 5 Oct 2002 21:54:53 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55313
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263070AbSJFByw>; Sat, 5 Oct 2002 21:54:52 -0400
Date: Sat, 5 Oct 2002 18:57:49 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Oliver Xymoron <oxymoron@waste.org>, Gigi Duru <giduru@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
In-Reply-To: <20021005232806.GG8530@conectiva.com.br>
Message-ID: <Pine.LNX.4.10.10210051856020.22517-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gigi Duru,

You just found your consultant, Arnaldo Carvalho de Melo!
Now issue a contract for deliverables on an opensource solution and become
a hero for embedded.

Andre Hedrick
LAD Storage Consulting Group

On Sat, 5 Oct 2002, Arnaldo Carvalho de Melo wrote:

> Em Sat, Oct 05, 2002 at 05:23:06PM -0500, Oliver Xymoron escreveu:
> > On Sat, Oct 05, 2002 at 12:36:50PM -0700, Gigi Duru wrote:
> 
> > > I know you guys are struggling to bring "world class VM & IO" to Linux,
> > > going for SMPs and other big toys, but you are about to lose what you
> > > already have: the embedded market.
>  
> > It's still plenty small enough for many many embedded uses and most people
> > are more than happy with it. The reason that it's not even smaller is no one
> > has stepped forward to do the trimming. It's easy enough to do, but we can
> > only assume from the fact that no one's done so is that it's really not that
> > important.
>  
> > If you think it's important, either make it happen or pay someone else to
> > make it happen. 
> 
> I've been thinking about working on a CONFIG_TINY for ages and would love to
> have somebody else beat me to do this, as currently I'm too busy saving old
> network protocols and with a backlog of patches for general network
> infrastructure (clean up include/linux/skbuff.h so that it doesn't have any
> reference to specific protocols, in the same way that I did for
> include/net/sock.h) and macroising access to stats in tcp/ip so that we can
> be preempt friendly.
> 
> I have also __initstr patches to free more memory after boot by moving the
> strings in __init functions to .data.init section that will help with
> embedded stuff as well. Some of the strings are passed to things like
> register_chrdev and would require changes in those register functions to
> copy the string passed as it will be freed after boot, etc.
> 
> - Arnaldo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

