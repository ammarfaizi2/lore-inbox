Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131829AbRCVF3n>; Thu, 22 Mar 2001 00:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131831AbRCVF3d>; Thu, 22 Mar 2001 00:29:33 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:33518 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S131829AbRCVF3N>; Thu, 22 Mar 2001 00:29:13 -0500
Date: Wed, 21 Mar 2001 21:27:47 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Omar Kilani <ok@mailcall.com.au>
cc: Marko Kreen <marko@l-t.ee>, Dalton Calford <dcalford@distributel.ca>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec/DPT RAID Drivers [Was: Re: DPT Driver Status]
In-Reply-To: <5.0.2.1.2.20010316021553.01c71480@172.17.0.107>
Message-ID: <Pine.LNX.4.30.0103212125220.28905-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a SmartCACHE IV...This driver seems not to recognize it.

I applied it to 2.4.2...the patch didn't apply cleanly, however.
I was able to manually patch the makefile to build the drivers for the
card however, but it still didn't want to work.

In any case, if you have any insight on this I'd much appreciate it, as
I'd like to get the card into production ASAP.

Thanks!

-Kelsey

On Fri, 16 Mar 2001, Omar Kilani wrote:

> Marko/Dalton/Unfortunate person searching for working DPT drivers,
>
> I too once felt your pain.
> Searched far and wide, etc.
> But then I stumbled upon ftp://ftp.suse.com/pub/people/mantel/next/
> Which has patches for everything you could ever want, all integrated, if
> you choose them to be.
> Anyway, inside those .tgz's was version 2.0 of the DPT I2O drivers.
> I've separated them from the .tgz, and stuck them up here:
>
> Kernel 2.2.18:
> http://aurore.net/source/dpt_i2o-2.0-2.2.18.gz
>
> Kernel 2.4.2
> http://aurore.net/source/dpt_i2o-2.0-2.4.2.gz
>
> Try 'em! :-) Not sure how they compare to Markos' version.
> I exchanged my ASR2100S for a Mylex AcceleRAID 170 - because DAC960 support
> is so much better ;-) and I loved reading through the DAC960 sources - so
> clean and easy to understand!
>
> Regards,
> Omar Kilani
>
> At 03:15 PM 3/14/01 +0200, Marko Kreen wrote:
> >On Wed, Mar 14, 2001 at 01:32:18AM -0500, Dalton Calford wrote:
> > > I have searched the archives, hunted through the adaptec site, tried
> > > multiple patches, compilers, revisions.....
> >
> >Me too...
> >
> > >
> > > I have a DPT/Adaptec DPT RAID V century card.  This has been a topic of
> > > much discussion in the past on this list.
> > >
> > > What I have found is that almost every file I find has a patch that is 6
> > > months old at best.
> >
> >When I last contacted them, couple of months ago, through
> >I-dunno-how-many-middle[wo]men they assured that
> >"driver is in developement" and "soon we make a release"...
> >
> > > I even contacted Deanna Bonds at Adaptec, but she has been unresponsive.
> > >
> > > Does anyone have a working patch for the 2.2.18 kernel?
> > > What is the most stable version of the kernel for the use of the patch?
> >
> >I have ported the 1.14 version of the driver to 2.2.18.
> >Basically converted their idea of patching with cp to
> >normal diff and dropped all reverse changes.
> >
> >   http://www.l-t.ee/marko/linux/dpt114-2.2.18p22.diff.gz
> >
> >It was for pre22 but applies cleanly to final 2.2.18.
> >The other soft was most current in valinux site:
> >
> >   http://ftp.valinux.com/pub/mirrors/dpt/
> >
> > > Has the native i2o driver been updated to handle what the dpt card is
> > > doing?
> >
> >No, the DPT driver has not been updated to native Linux i2o.
> >
> >Note: the driver compiles only with gcc 2.7.2.3, (dunno about
> >egcs).  2.95.2 makes it acting weird.  I do not know if
> >thats gcc or driver problem.
> >
> >--
> >marko
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

