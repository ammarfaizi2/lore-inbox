Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbRF3RGq>; Sat, 30 Jun 2001 13:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266212AbRF3RGg>; Sat, 30 Jun 2001 13:06:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6416 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266210AbRF3RGT>; Sat, 30 Jun 2001 13:06:19 -0400
Date: Sat, 30 Jun 2001 12:33:08 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: VM behaviour under 2.4.5-ac21
In-Reply-To: <20010630012017.A5048@werewolf.able.es>
Message-ID: <Pine.LNX.4.21.0106301232490.3227-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Jun 2001, J . A . Magallon wrote:

> 
> On 20010629 Martin Knoblauch wrote:
> >Hi,
> >
> > just something positive for the weekend. With 2.4.5-ac21, the behaviour
> >on my laptop (128MB plus twice the sapw) seems a bit more sane. When I
> >start new large applications now, the "used" portion of VM actually
> >pushes against the cache instead of forcing stuff into swap. It is still
> >using swap, but the effects on interactivity are much lighter.
> >
> 
> I was just going to say the same. After ac20, I think, the kernel stopped
> pre-allocating swap.
> Before I had always some swap used even if I was only using half my core memory
> (256Mb). And growing. I have not seen the box touch the swap since ac20.
> It uses all the ram it can get for cache, but does not send anything  to swap
> to use its ram for cache.
> Now running ac21 while building ac22, and state is:
> werewolf:/usr/src# free
>              total       used       free     shared    buffers     cached
> Mem:        255588     241044      14544       2168       8836     153752
> -/+ buffers/cache:      78456     177132
> Swap:       152576          0     152576
> werewolf:/usr/src# vmstat
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  1  0  0      0   6944   8836 153868   0   0    16    12   95   385  17   3  80
> 

Weird: there is no VM change between ac20 and 21.

