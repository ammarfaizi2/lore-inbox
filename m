Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269019AbRHBPUa>; Thu, 2 Aug 2001 11:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269021AbRHBPUU>; Thu, 2 Aug 2001 11:20:20 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:19930 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S269019AbRHBPUO>;
	Thu, 2 Aug 2001 11:20:14 -0400
Date: Thu, 2 Aug 2001 17:19:02 +0200
From: David Weinehall <tao@acc.umu.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Vandomelen <chrisv@b0rked.dhs.org>,
        Nerijus Baliunas <nerijus@users.sourceforge.net>,
        Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: cannot copy files larger than 40 MB from CD
Message-ID: <20010802171902.H6387@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.31.0107311656420.10245-100000@linux.local> <E15SKBL-0000qt-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E15SKBL-0000qt-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 02, 2001 at 04:14:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 04:14:39PM +0100, Alan Cox wrote:
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

gcc 2.95.4 seem to be working too.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
