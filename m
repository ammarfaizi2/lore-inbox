Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283603AbSAATlP>; Tue, 1 Jan 2002 14:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283259AbSAATlF>; Tue, 1 Jan 2002 14:41:05 -0500
Received: from [212.84.215.194] ([212.84.215.194]:17163 "EHLO reactor.hyte.de")
	by vger.kernel.org with ESMTP id <S283594AbSAATky>;
	Tue, 1 Jan 2002 14:40:54 -0500
Date: Tue, 1 Jan 2002 19:42:03 +0100 (CET)
From: Joachim Steiger <roh@hyte.de>
To: Bill Nottingham <notting@redhat.com>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        James Simmons <jsimmons@transvirtual.com>,
        Scott McDermott <vaxerdec@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <20011231214322.A26481@nostromo.devel.redhat.com>
Message-ID: <Pine.LNX.4.21.0201011928590.2321-100000@reactor.hyte.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i didn't wrote it, i can only give you a hint where to find it
so you can try it

http://directfb.org/cgi-bin/cvsweb.cgi/~checkout~/
DirectFB/patches/neofb-0.3-linux-2.4.17.patch.bz2

it applys fine an i have i patched it in out own working tree
as far as i know it is tested on acer, sony vaio and some thinkpad
and works great.
since 0.3 move and clear is implemented by using the acclerator on nm2200
and above so you really gain speed when scrolling though your consoles

there is also some patch for aty128fb i use some time now without any
problems... anyway... now my ati works, before it doesnt.

have fun testing, and yes... a textconsole at native resolution is that
what i need to work with an lc-monitor.... 1600x1024 looks great booting
at native resolution:
Console: switching to colour frame buffer device 200x64

On Mon, 31 Dec 2001, Bill Nottingham wrote:

> Arnaldo Carvalho de Melo (acme@conectiva.com.br) said: 
> > My card is a Neomagic, so I use vesafb...
> > 
> > Please let me know if somebody has specs for:
> > 
> > 00:08.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph
> > 128XD] (rev 01)
> 
> Someone wrote a neomagic framebuffer driver at some point; ISTR
> the patch showing up on linux-kernel. Mind you, I don't know that
> it was accelerated at all...
> 
> Bill

