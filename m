Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289004AbSAFSkE>; Sun, 6 Jan 2002 13:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289005AbSAFSjy>; Sun, 6 Jan 2002 13:39:54 -0500
Received: from mercury.ccmr.cornell.edu ([128.84.231.97]:58891 "EHLO
	mercury.ccmr.cornell.edu") by vger.kernel.org with ESMTP
	id <S289004AbSAFSjk>; Sun, 6 Jan 2002 13:39:40 -0500
From: Daniel Freedman <freedman@ccmr.cornell.edu>
Date: Sun, 6 Jan 2002 13:39:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Message-ID: <20020106133939.A6408@ccmr.cornell.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 01 2002, H. Peter Anvin (hpa@zytor.com) wrote:
> By author: Alan Cox <alan@lxorguk.ukuu.org.uk>
> >
> > > 2. Isn't the boundary at 2^30 really irrelevant and the three "correct"
> > > zones are (0 - 2^24-1), (2^24 - 2^32-1) and (2^32 - 2^36-1)?
> >
> > Nope. The limit for directly mapped memory is 2^30.
> >
> 
> 2^30-2^27 to be exact (assuming a 3:1 split and 128MB vmalloc zone.)
> 
>         -hpa

For my better understanding, where's the 128MB vmalloc zone assumption
defined, please?

I'm pretty sure I understand that the 3:1 split you refer to is
defined by PAGE_OFFSET in asm-i386/page.h

But when I tried to find the answer in the source for the vmalloc
zone, I looked in linux/mm.h, linux/mmzone.h, linux/vmalloc.h, and
mm/vmalloc.c, but couldn't find anything there or in O'Reilly's kernel
book that I could follow/understand.

Thanks for any pointers.

Take care,

Daniel

-- 
Daniel A. Freedman
Laboratory for Atomic and Solid State Physics
Department of Physics
Cornell University
