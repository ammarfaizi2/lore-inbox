Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316597AbSEUUiq>; Tue, 21 May 2002 16:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSEUUip>; Tue, 21 May 2002 16:38:45 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1178 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316597AbSEUUin>;
	Tue, 21 May 2002 16:38:43 -0400
Date: Thu, 16 May 2002 23:27:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Pete Zaitcev <zaitcev@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020516232734.B116@toy.ucw.cz>
In-Reply-To: <E178sfK-0006dG-00@wagner.rustcorp.com.au> <E178uPV-0007iX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > and foolish to program without reading interface specifications
> > > or the code. It did not occur to me to shift the blame onto
> > > copy_from_user creators.
> > 
> > Please send me your mailing address.  I shall send you a copy of
> > "Design of Everyday Things" (Donald A Norman).  You should not blame
> > yourself for others' bad design.
> 
> By extrapolation perhaps you'd also care to reimplement it in terms of
> exceptions, refcount the objects with an object based primitive to do the
> transfers, garbage collect to remove memory leaks and implement strings and
> variable size buffers as base objects.

Actually, no. 0 vs. -ERRNO is common in kernel, objects are not.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

