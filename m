Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269068AbRHBTy2>; Thu, 2 Aug 2001 15:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269082AbRHBTyS>; Thu, 2 Aug 2001 15:54:18 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:27063 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S269068AbRHBTyK>; Thu, 2 Aug 2001 15:54:10 -0400
Date: Thu, 2 Aug 2001 14:54:09 -0500
From: J Troy Piper <jtp@dok.org>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, chrisv@b0rked.dhs.org,
        nerijus@users.sourceforge.net, dwguest@win.tue.nl
Subject: Re: cannot copy files larger than 40 MB from CD
Message-ID: <20010802145409.A2217@dok.org>
Mime-Version: 1.0
Content-Type: message/rfc822
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.08.02 10:14 Alan Cox wrote:
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
> egcs-1.1.2 aka kgcc wont build 2.4.7 it seems. gcc 2.96 >= 2.96.75 or so
> is
> just fine, gcc 2.95-2/3 is fine, gcc 3.0 seems to be doing the right
> thing
> -

Sounds to me like someone needs to check their ulimit.
---

