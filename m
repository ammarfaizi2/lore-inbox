Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282170AbRKWQMV>; Fri, 23 Nov 2001 11:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282172AbRKWQML>; Fri, 23 Nov 2001 11:12:11 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:31185 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282170AbRKWQMB>; Fri, 23 Nov 2001 11:12:01 -0500
Message-Id: <5.1.0.14.2.20011123160559.00a8d8b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 23 Nov 2001 16:10:48 +0000
To: lgb@lgb.hu
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Which gcc version?
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011123163019.A5418@vega.digitel2002.hu>
In-Reply-To: <3BFE67E8.CFA0D371@redhat.com>
 <20011123125137Z282133-17408+17815@vger.kernel.org>
 <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk>
 <3BFE591B.D1F75CD5@starband.net>
 <3BFE67E8.CFA0D371@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:30 23/11/01, =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= wrote:
>On Fri, Nov 23, 2001 at 03:14:48PM +0000, Arjan van de Ven wrote:
> > war wrote:
> > >
> > > #1) The compiler from redhat (gcc-2.96) is not an official GNU release.
> > > #2) http://www.atnf.csiro.au/~rgooch/linux/docs/kernel-newsflash.html/
> > >       "the reccomend compiler is now gcc-2.95.3, rather than gcc-2.91.66"
> >
> > From Documentation/Changes in 2.4.15:
> >
> > The Red Hat gcc 2.96 compiler subtree can also be used to build this
> > tree.
> > You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not
> > build
> > the kernel correctly.
>
>True, but as it's known, gcc-2.96 is NOT an official gcc release by the gcc
>team. It was RedHat's fault to fetch a development CVS gcc snapshot and
>release it as gcc 2.96 in RedHat distributions, while object format used by
>2.96 is not compatible with 2.95 nor 3.0.x at least according information
>can be found on site of gcc. It was very ROTFL RedHat to release kgcc to be
>able to compile kernel. And these type of distributions are marked as even
>enterprise-ready and likes by RedHat :) Sorry for the flame, but IMHO it's
>very funny :) [Also, while developing MPlayer we had got problems with even
>newer 2.96's, so we do not recommend it in the dox, and ./configure won't
>able you to use 2.96 without a special configure switch ...]

Oh, I have to look at your configure.in for how you do that so I can add 
the opposite check to linux-ntfs and refuse to compile if gcc-2.96 or 3.x 
is NOT used. (-:

>But for being more serious: do newer gcc 2.96 versions have these type of
>errors? I mean mainly incompatible object format ...

I don't know about that. All I can say is that since RedHat 7.0 and the 
updated gcc-2.96 (the first release was indeed broken) I have been using 
gcc-2.96 for everything and I haven't experienced any problems with it 
(compiling both kernels and user space code with it but YMMV as I don't 
compile that much user space code myself except for my own code which 
obviously works considering I write it for gcc-2.96...). I even installed 
gcc-2.96 on my SuSE 7.2 system and that has been happy with it, too.

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

