Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287333AbSACPug>; Thu, 3 Jan 2002 10:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287330AbSACPu1>; Thu, 3 Jan 2002 10:50:27 -0500
Received: from [198.17.35.35] ([198.17.35.35]:56471 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S287333AbSACPuR>;
	Thu, 3 Jan 2002 10:50:17 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2A51@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Ricky Beam'" <jfbeam@bluetronic.net>,
        Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: RE: Two hdds on one channel - why so slow?
Date: Thu, 3 Jan 2002 07:49:56 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has always been a really FUN argument

IDE vs. SCSI

BTW, why not add FC-AL or Serial-ATA into the mix, too?

i just wanted to add one thing.  you guys are all right so
far, IDE has distinct advantages and so does linux, but you're
missing something :

SCSI is meant for high performance, high reliability systems.
it's not that the SCSI protocol is meant for this, but the
drives are.  the drive quality for SCSI drives is MUCH higher
examples :
IBM's flagship 120GXP IDE drive is rated as 1 in 10^13 error rate,
with 40K start/stop cycles and a three year warranty.
IBM's 36Z15 SCSI drive is rated at 1 in 10^16 with 50K cycles
and a FIVE year warranty.

seagate and maxtor have similar differences.

If you're running a production system UNDER LOAD for 24x7 then
you should be using SCSI.  there's not really any room for
argument here is there? :)

Dana Lacoste
Ottawa, Canada
(Using SCSI on desktop [silly] and in product [woo-hoo!] :)

> -----Original Message-----
> From: Ricky Beam [mailto:jfbeam@bluetronic.net]
> Sent: January 3, 2002 00:58
> To: Mark Hahn
> Cc: Linux Kernel Mail List
> Subject: Re: Two hdds on one channel - why so slow?
> 
> 
> On Wed, 2 Jan 2002, Mark Hahn wrote:
> >my goodness; it's been so long since l-k saw this traditional sport!
> >nothing much has changed in the intrim: SCSI still costs 
> 2-3x as much,
> >and still offers the same, ever-more-niche set of advantages
> >(decent hotswap, somewhat higher reliability, moderately 
> higher performance,
> >easier expansion to more disks and/or other devices.)
> 
> If it's so much of a niche (and by extension desired by so 
> few), why has
> IDE become more and more like SCSI over the past decade?  IDE is just
> beginning (over the last 2-3 years) to acquire the features 
> SCSI has had
> for over a decade.  Give it another decade and IDE will 
> simply be a SCSI
> physical layer.
> 
> So summarize a decade old arguement:
> (IDE Camp)  SCSI sucks because it's too damned expensive.
> 
> (SCSI Camp) IDE sucks because it isn't SCSI. [followed by a 
> long list of
>             features present in SCSI but not IDE.]
> 
> You cannot beat IDE's price/performance with a stick.  However, anyone
> who cares about system performance (and lifespan) will opt 
> for the expense
> of SCSI.
> 
> >besides having missed the last 2-3 generations of ATA (which include
> >things like diskconnect), you have clearly not noticed that 
> entry-level
> 
> And who has diskconnect implemented?  How many devices support it?
> How many years before most of the hideous data destroying bugs and
> incompatibilities are rooted out?
> 
> >hardware with PoS UDMA100 controllers can sustain more bandwidth than
> >you can hope to consume (120 MB/s is pretty easy, even on 32x33 PCI!)
> 
> ...with only two devices per channel and a rather heavy 
> penalty for more
> than one.  SCSI is only significantly penalized when approaching bus
> saturation.
> 
> And looking at the data rates for the Maxtor 160GB drive (infact the
> entire D540X line)... 43.4M/s to/from media (i.e. cache) with 
> sustained
> rates of 35.9/17.8 OD/ID.  Maxtor are the only ones with U133 drives.
> (And the Maxtor SCSI drives kick that thing's ass... internal rate of
>  350-622Mb/s for a sustained throughput of 33-55MB/s.  Expensive but
>  much much faster.)
> 
> >> PS: I once turned down a 360MHz Ultra10 in favor of a 
> 167MHz Ultra1 because
> >>     of the absolutely shitty IDE performance.  The U1 was 
> actually faster
> >>     at compiling software. (Solaris 2.6, btw)
> >
> >yeah, if Sun can't make IDE scream, then no one can eh?
> 
> Linux wasn't any freakin' better at it.  (Sun's IDE still 
> seriously sucks.)
> 
> --Ricky
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
