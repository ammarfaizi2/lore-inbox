Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312410AbSDCWN7>; Wed, 3 Apr 2002 17:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312408AbSDCWNu>; Wed, 3 Apr 2002 17:13:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50049 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312411AbSDCWNi>; Wed, 3 Apr 2002 17:13:38 -0500
Date: Wed, 3 Apr 2002 17:17:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gerd Knorr <kraxel@bytesex.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <slrnaamprq.tuj.kraxel@bytesex.org>
Message-ID: <Pine.LNX.3.95.1020403171242.12859A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Apr 2002, Gerd Knorr wrote:

> Alan Cox wrote:
> > > The fact that the code was back-ported from 2.5.x and that the _GPL still 
> > > is there too is just a mistake, partly because I've not gotten any updates 
> > > from Ingo..
> >  
> >  So Linus is allowed to arbitarily export other peoples contributions ? I
> >  think we need to clear this one up and understand what people think the
> >  actual rules are around here. As I understand it the original code was
> >  a) extracted from bttv and is code which I and DaveM partly wrote
> >  b) was submitted by Gerd who did the extra work and kept it as _GPL when he 
> >     first exported it. (in 2.4 its relevant to expose it as we have the V4L1
> >     not V4L2 interface)
> 
> No.

This is getting pretty tired.

This is truly amazing. Think about it. For years Linux enthusiasts
have been trying to take over the world. They wanted everybody to use
it. They wanted everyone to accept it as the greatest thing since
COBOL.

Now, the world is starting to take notice. Linux is actively and
publicly supported by the likes of Intel, IBM, and other major
players. So what happens?

We now have developers, contributors, and others who are saying;
"Whoa, now! I don't want just 'anybody' to use __my__ code!!".

Well, you can't have it both ways. If you want the world to use
Linux, then the companies that spend their money making programs
and drivers that work with Linux are going to have to be able
to keep their own hard-earned code from their competitors, or the
companies that hire the Engineers that write the code will soon
be out-of-business, their work having been stolen by others.

I have first-hand experience. Microsoft made a lot of money,
getting into the consumer market, with Flight Simulator. This
was written my myself and several other contributors to the
"PROGRAM EXCHANGE", a long ago defunct BBS System. Before the
Internet was commonplace we had BBS Systems. I was so proud
of the assembly-language state-machine and others were so proud
of the Turbo-Pascal GUI that we _had_ to publish it. The fact
that thieves existed was not a consideration.

So grow up. This whole
     "EXPORT_THIS_SYMBOL_ONLY_IF_YOU_WILL_ME_YOUR_FIRST_BORN()"
is unmitigated bullshit.

A symbol should be exported when there is a technical need for
it to be exported. None of us want a bloated kernel with 20 interfaces
into a kernel-mode memory allocator any more than we want as many
memcpy() functions. If you can't allow somebody to use (meaning
intercace-with) "your" code then kindly send a patch that removes it.
In a few days it will be replaced with something that probably works
better, written by somebody who would be proud to have others interface
with it.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

