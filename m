Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266144AbSKTOAr>; Wed, 20 Nov 2002 09:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbSKTOAr>; Wed, 20 Nov 2002 09:00:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12421 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266144AbSKTOAq>; Wed, 20 Nov 2002 09:00:46 -0500
Date: Wed, 20 Nov 2002 09:09:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Xavier Bestel <xavier.bestel@free.fr>, Mark Mielke <mark@mark.mielke.cc>,
       Rik van Riel <riel@conectiva.com.br>,
       David McIlwraith <quack@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
In-Reply-To: <1037801955.3241.21.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1021120085905.9083A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov 2002, Alan Cox wrote:

> On Wed, 2002-11-20 at 10:17, Xavier Bestel wrote:
> > Yeah, that's precisely the problem here: the binary-only module is
> > distributed with included spinlock code, which *is* GPL.
> 
> That doesnt neccessarily make it a derived work. Suppose I publish a
> book including a lawyer who says "Your honour I ...". That doesn't make
> it a derivative of some previous work I read that used the same phrase.
> 
> Equally if I paraphase the entire court scene but use no identical words
> it may be a derived work. 
> 
> Stop thinking about this as a mathematical question. It isnt about the
> union of sets of instructions.
> 
> Alan
> 

Well stated. Further "spin-locks" are generic things that have nothing
to do with Linux, much less GPL. It has been pretty much established
that there are some kernel internals that writers have insisted cannot
be accessed except by GPL code. These are typically complex things
that can be easily broken by incorrect access. Therefore, the writer
insists that if you access that procedure, or tamper with the elements
of some structure, then your code must be GPL so that it may be
publicly scrutinized. There is other kernel code that is so obvious
that, even though an incorrect access can break things, the writer
figured that if you break it, you just keep the pieces. So, it
boils down to what lawyers call "intent". And as Alan stated, it
isn't mathematics.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


