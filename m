Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282160AbRKWOpN>; Fri, 23 Nov 2001 09:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282161AbRKWOpF>; Fri, 23 Nov 2001 09:45:05 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:41148 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282160AbRKWOo5>; Fri, 23 Nov 2001 09:44:57 -0500
Message-Id: <5.1.0.14.2.20011123142135.00a98ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 23 Nov 2001 14:43:55 +0000
To: war <war@starband.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Which gcc version?
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3BFE591B.D1F75CD5@starband.net>
In-Reply-To: <20011123125137Z282133-17408+17815@vger.kernel.org>
 <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:11 23/11/01, war wrote:
>#1) The compiler from redhat (gcc-2.96) is not an official GNU release.

And anyone should care because...?

>#2) http://www.atnf.csiro.au/~rgooch/linux/docs/kernel-newsflash.html/
>       "the reccomend compiler is now gcc-2.95.3, rather than gcc-2.91.66"

Several main kernel developers use gcc-2.96 for their kernel development 
work and according to Alan Cox using gcc-2.96 for the kernel is fine (from 
a certain version onwards, can't remember the minimum release number he 
said but the one in RH 7.2 is fine in any case).

Considering the person asking was giving gcc-2.96 and gcc-3.x as choices, 
and was saying he is using RH 7.2, answering he should be using a third 
choice is IMO not a very constructive answer, considering one of the 
original choices is fine!

And anyway, the ultimate guide is the Documentation/Changes document in the 
kernel tree which states (cut'n'paste from kernel 2.4.15):

"The Red Hat gcc 2.96 compiler subtree can also be used to build this tree.
You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not build
the kernel correctly."

So while you are right that gcc-2.95.3 or .4 is the recommended compiler, 
gcc-2.96 if an officially supported compiler, too. (-;

Best regards,

Anton

>Anton Altaparmakov wrote:
>
> > At 13:51 23/11/01, war wrote:
> > >You should use gcc-2.95.3.
> >
> > That's not true. gcc-2.96 as provided with RedHat 7.2 is perfectly fine.
> >
> > gcc-3x OTOH is not a good idea at the moment.
> >
> > Anton
> >
> > >Roy Sigurd Karlsbakk wrote:
> > >
> > > > hi all
> > > >
> > > > I just wonder...
> > > > With a clean rh72 install, I've got two gcc versions installed in 
> parllel,
> > > > 2.96 and 3.0.2. Which one should I use to compile the kernel?
> > > >
> > > > thanks
> > > >
> > > > roy
> > > > --
> > > > Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> > > >
> > > > Computers are like air conditioners.
> > > > They stop working when you open Windows.
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > >-
> > >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > >the body of a message to majordomo@vger.kernel.org
> > >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >Please read the FAQ at  http://www.tux.org/lkml/
> >
> > --
> >    "I've not lost my mind. It's backed up on tape somewhere." - Unknown
> > --
> > Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> > Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
> > ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

