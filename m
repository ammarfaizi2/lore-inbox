Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269331AbRHCINJ>; Fri, 3 Aug 2001 04:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269345AbRHCINA>; Fri, 3 Aug 2001 04:13:00 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:3590 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S269336AbRHCIMs>; Fri, 3 Aug 2001 04:12:48 -0400
From: bvermeul@devel.blackstar.nl
Date: Fri, 3 Aug 2001 10:15:41 +0200 (CEST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chris Vandomelen <chrisv@b0rked.dhs.org>,
        Nerijus Baliunas <nerijus@users.sourceforge.net>,
        Guest section DW <dwguest@win.tue.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: cannot copy files larger than 40 MB from CD
In-Reply-To: <E15SKBL-0000qt-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108031011500.28108-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Alan Cox wrote:

> > > Tried vfat, ext2 and reiserfs.
> > >
> > > BTW, kernel is compiled with gcc-2.96-85, glibc-2.2.2-10 (RH 7.1) if
> >                                ^^^^^^^^^^^
> > > that matters.
> >
> > Have you tried compiling your kernel using kgcc?
> >
> > gcc-2.96.* is known to compile code incorrectly AFAIK, and shouldn't be
> > used for compiling kernels. (kgcc is egcs-1.1.2, I think.)
>
> [x86 hat on]
>
> egcs-1.1.2 aka kgcc wont build 2.4.7 it seems. gcc 2.96 >= 2.96.75 or so is
> just fine, gcc 2.95-2/3 is fine, gcc 3.0 seems to be doing the right thing

egcs-1.1.3 *does* build 2.4.7, if you use the right binutils
(2.10.91.0.2 worked for me). I'm running 2.4.7-ac3 with ext3 patches on an
old dual P200. Haven't had a crash yet, been up 2 days and counting.

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

