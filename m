Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSJOOSc>; Tue, 15 Oct 2002 10:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262697AbSJOOSc>; Tue, 15 Oct 2002 10:18:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52679 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262692AbSJOOSb>; Tue, 15 Oct 2002 10:18:31 -0400
Date: Tue, 15 Oct 2002 16:24:16 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Roman Zippel <zippel@linux-m68k.org>
cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux kernel conf 0.9
In-Reply-To: <Pine.LNX.4.44.0210151556570.338-100000@serv>
Message-ID: <Pine.NEB.4.44.0210151617150.20607-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Tue, 15 Oct 2002, Adrian Bunk wrote:
>
> > $ cd /tmp/
> > $ tar xzf lkc-0.9.tar.gz
> > $ cd lkc-0.9
> > $ make
> > ...
> > $ cd ~/linux/kernel-2.5
> > $ tar xzf linux-2.5.42.tar.gz
> > $ cd linux-2.5.42
> > $ bzcat /tmp/lkc-0.9-2.5.42.diff.bz2 |patch -p1
> > ...
> > $ /tmp/lkc-0.9/lkcc i386
>
> Umm, now I see the problem, the patch already contains everything, so you
> don't need to convert anything after applying it. If you want to convert
> your kernel tree, it's best to use 'make install KERNELSRC=...' target in
> lkc.

ah thanks, that's it. This is the way it's described in lkc.html, I was
only looking at lkc-0.9/README where I didn't find this information...

> bye, Roman

cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed


