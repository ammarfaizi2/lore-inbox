Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSGLIsk>; Fri, 12 Jul 2002 04:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSGLIsj>; Fri, 12 Jul 2002 04:48:39 -0400
Received: from dsl-213-023-020-198.arcor-ip.net ([213.23.20.198]:39832 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314553AbSGLIsj>;
	Fri, 12 Jul 2002 04:48:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ludwig" <cl81@gmx.net>, "Ville Herva" <vherva@niksula.hut.fi>
Subject: Re: bzip2 support against 2.4.18
Date: Fri, 12 Jul 2002 10:52:42 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <E17Suso-0002dn-00@starship> <003f01c2297e$b3e395d0$1c6fa8c0@hyper>
In-Reply-To: <003f01c2297e$b3e395d0$1c6fa8c0@hyper>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17SwAM-0002e2-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 July 2002 10:32, Christian Ludwig wrote:
> Daniel wrote on Friday, July 12, 2002:
> > On Friday 12 July 2002 08:36, Christian Ludwig wrote:
> > > But the question is: who is responsible for all those naming
> conventions?
> > > Does anyone has an idea?
> >
> > You are, it's your patch.  And I've taken upon myself the responsibility
> > of heaving the decaying vegetables deserved by your first attempt.
> >
> > Actually, what is the use of even including 'bz2' in the name?  Nobody
> > besides we geeks needs to know the thing is compressed with bzip2.  It
> > would be nice to see the word 'linux' in there.  How about bzlinux?
> > Just think of the hundreds of cases of carpal tunnel syndrome you'd
> > prevent by eliminating the shifted character.
> 
> First, thanks for your help!
> Surely it is better not to have a capital letter. My idea to have that 'bz2'
> in the name was that you could also have some more kernel compression
> algorithms some day. For all of these you would need new names.

Do you really?  Why?  Exactly what purpose does it serve to know how your
kernel was compressed, considering that it knows how to uncompress itself?

> To make it
> at least a little bit easier there should be that 'bz2' in the name. So
> 'bz2linux' would be a goal. But if we do this we also could change 'bzImage'
> to 'gzlinux'.

You can feel pretty confident in thinking the name bzImage is never going
to change, if only because too many fingers know how to type the stupid
thing by reflex action.

> On the other hand I also had the idea to let the name 'bzImage' be for both,
> gzip and bzip2. The problem is that I can neither overload the name nor
> choose the kernel compression at configuration time [I do not know how to
> make it at least].

Now that you mention it, bzImage should continue to serve perfectly well,
so long as you have some other way of configuring the kernel compression
method than via the make target.  Why not just make the compression method
a config option?  If it had been done this way from the beginning, we'd 
never have acquired the b or the z.

This way you avoid the entire controversy of chosing a new name for the
kernel image, and anyway, it's a nicer interface than via the make
target.

/me thinks for a moment about the idea of encoding every single config
option in the name of the name of the image file and shudders

-- 
Daniel
