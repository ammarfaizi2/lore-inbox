Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293507AbSBZE1L>; Mon, 25 Feb 2002 23:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293508AbSBZE1C>; Mon, 25 Feb 2002 23:27:02 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:13702 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293507AbSBZE04>;
	Mon, 25 Feb 2002 23:26:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        DevilKin <DevilKin-LKML@blindguardian.org>
Subject: Re: Linux 2.4.18
Date: Sun, 24 Feb 2002 06:20:18 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0202251631170.31542-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0202251631170.31542-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16er58-0001QX-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 25, 2002 08:31 pm, Marcelo Tosatti wrote:
> On Mon, 25 Feb 2002, DevilKin wrote:
> > On Monday 25 February 2002 20:18, Marcelo Tosatti wrote:
> > > On Mon, 25 Feb 2002, Holzrichter, Bruce wrote:
> > > > > Ok, DAMN. I missed the -rc4 patch in 2.4.18. Real sorry about that.
> > > > >
> > > > > 2.4.19-pre1 will contain it.
> > > >
> > > > Should 2.4.18 final get a -dontuse tag or something?
> > >
> > > No. A "-dontuse" tag should be only used when the kernel can cause damage
> > > in some way.
> > >
> > > The patch which I missed only breaks static apps on _some_ architectures
> > > (not including x86).
> > >
> > > > Some people may get confused grabbing 2.4.18 and not getting the fixes
> > > > that went into rc-4? Just a thought...
> > >
> > > I already changed ftp.kernel.org's changelog adding:
> > >
> > > "Update: The SET_PERSONALITY fix in rc4 has _not_
> > > been included in the final 2.4.18 by mistake."
> > >
> > > I guess thats enough.
> > 
> > Wouldn't it be easier just to make a new 2.4.18 with the patch applied?
> > 
> > Just to make all our lives a bit easier...
> 
> Having two 2.4.18's is a bit of a mess for the ftp.kernel.org mirroring
> system.

That suggests the mirroring system is flawed.  It should be possible to
do a quick cancel on an upload, much as with a usenet post.  Not that it
should become a habit of course, but it seems something's missing.  We've
had a number of events this year where a cancel would have saved a lot of
confusion and handwringing.

-- 
Daniel
