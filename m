Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292432AbSBPQyu>; Sat, 16 Feb 2002 11:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292443AbSBPQx3>; Sat, 16 Feb 2002 11:53:29 -0500
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:19927
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S292442AbSBPQxU>; Sat, 16 Feb 2002 11:53:20 -0500
Date: Sat, 16 Feb 2002 11:53:13 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <20020216110006.A32129@thyrsus.com>
Message-ID: <Pine.LNX.4.44.0202161135000.16872-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2002, Eric S. Raymond wrote:

> Nicolas Pitre <nico@cam.org>:
> > Show us that you're able to write a 1 for 1 functional correspondance
> > between CML1 and CML2 and propose that for inclusion into 2.5.
> 
> This requirement is absurd.  When someone designs a new VM, we
> don't demand that it crash or lock up the system in exactly the same
> way that the old one did before it can go into the kernel.

When someone design a new VM, and decides that it must be written in a 
totally new language with a new compiler, that someone will certainly face 
big resistance unless it can be proven that the new language can do exactly 
the same as the old one so other developers can get used to it first... 
especially if the old VM doesn't crash the system that often or maybe never 
for many users.

So yes, it might look absurd from your point of view but it's not for most
people not familiar with CML2.  And if that's what most of your opponants
are asking for why don't you give them just that?  Prove them that you're 
able to _split_ the concepts apart i.e. first the language vocabulary and 
tools, then the improved grammar, then the advanced configuration features, 
then the ultimate philosophical changes, etc.

Wake up Eric!

If people want A, B, C, agree somewhat with D, but have problems with E, do 
you realise that they will reject the whole thing at once if the only way 
you can present things is by submiting ABCDEFG indistinguishly?

Do things in steps.  First the struct translation of CML1 into CML2 with the 
new coherent frontends.  That's it.  If you can't do that then give up now 
and don't spent more time on CML2 because it will never go anywhere as the 
Linux kernel is concerned.


Nicolas

