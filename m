Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283309AbRLDStm>; Tue, 4 Dec 2001 13:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283266AbRLDSsC>; Tue, 4 Dec 2001 13:48:02 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:55473 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S283273AbRLDSq5>;
	Tue, 4 Dec 2001 13:46:57 -0500
Date: Tue, 4 Dec 2001 19:46:52 +0100
From: David Weinehall <tao@acc.umu.se>
To: =?iso-8859-1?Q?Ra=FAlN=FA=F1ez_de_Arenas_Coronado?= 
	<raul@viadomus.com>
Cc: linux-kernel@vger.kernel.org, matthias.andree@stud.uni-dortmund.de,
        esr@thyrsus.com, hch@caldera.de, kaos@ocs.com.au,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204194652.F360@khan.acc.umu.se>
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com>; from raul@viadomus.com on Tue, Dec 04, 2001 at 06:08:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:08:57PM +0100, RaúlNúñez de Arenas Coronado wrote:
>     Hi Matthias :)
> 
> >Creating a dependency on Python? Is a non-issue.
> 
>     Maybe for you. For me it *is* an issue. I don't like more and
> more dependencies for the kernel. I mean, if I can drop kbuild and
> keep on building the kernel with the old good 'make config' I won't
> worry, but otherwise I don't think that kernel building depends on
> something like Python.
> 
>     Why must I install Python in order to compile the kernel? I don't
> understand this. I think there are better alternatives, but kbuild
> seems to be imposed any way.
> 
> >You don't make the pen yourself when writing a letter either.
> 
>     I don't like to be forced in a particular pen, that's the reason
> why I use and develop for linux.
> 
> >What are the precise issues with Python? Just claiming it is an
> >issue is not useful for discussing this. Archive pointers are
> >welcome.
> 
>     Well, let's start writing kernel drivers with Python, Perl, PHP,
> awk, etc... And, why not, C++, Ada, Modula, etc...

Noone's suggested writing kernel-drivers in anything but a combination
of C and assembler (with as little asm as possible), apart from some
heretics that suggested usage of C++ in the kernel...

This only involves usage of Python2 for configuring your kernel.

>     The kernel should depend just on the compiler and assembler, IMHO.

Yeah, let's lose the dependencies on perl, make, awk, sed, ld, ar,
nm, strip, objcopy, objdump, depmod, grep, xargs, find, gzip,
wish, tcl/tk and possibly others. That'd surely shave a lot of diskspace
off my buildsystem. It's not like I use any of them for anything else...

Hey, lets lose C and ASM too, and create all your binaries by
writing hexvalues into a file.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
