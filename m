Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288211AbSACF6T>; Thu, 3 Jan 2002 00:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288210AbSACF6J>; Thu, 3 Jan 2002 00:58:09 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:53386 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S288215AbSACF56>; Thu, 3 Jan 2002 00:57:58 -0500
Date: Thu, 3 Jan 2002 00:57:55 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <Pine.LNX.4.33.0201022010340.10236-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.GSO.4.33.0201030012090.28783-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Mark Hahn wrote:
>my goodness; it's been so long since l-k saw this traditional sport!
>nothing much has changed in the intrim: SCSI still costs 2-3x as much,
>and still offers the same, ever-more-niche set of advantages
>(decent hotswap, somewhat higher reliability, moderately higher performance,
>easier expansion to more disks and/or other devices.)

If it's so much of a niche (and by extension desired by so few), why has
IDE become more and more like SCSI over the past decade?  IDE is just
beginning (over the last 2-3 years) to acquire the features SCSI has had
for over a decade.  Give it another decade and IDE will simply be a SCSI
physical layer.

So summarize a decade old arguement:
(IDE Camp)  SCSI sucks because it's too damned expensive.

(SCSI Camp) IDE sucks because it isn't SCSI. [followed by a long list of
            features present in SCSI but not IDE.]

You cannot beat IDE's price/performance with a stick.  However, anyone
who cares about system performance (and lifespan) will opt for the expense
of SCSI.

>besides having missed the last 2-3 generations of ATA (which include
>things like diskconnect), you have clearly not noticed that entry-level

And who has diskconnect implemented?  How many devices support it?
How many years before most of the hideous data destroying bugs and
incompatibilities are rooted out?

>hardware with PoS UDMA100 controllers can sustain more bandwidth than
>you can hope to consume (120 MB/s is pretty easy, even on 32x33 PCI!)

...with only two devices per channel and a rather heavy penalty for more
than one.  SCSI is only significantly penalized when approaching bus
saturation.

And looking at the data rates for the Maxtor 160GB drive (infact the
entire D540X line)... 43.4M/s to/from media (i.e. cache) with sustained
rates of 35.9/17.8 OD/ID.  Maxtor are the only ones with U133 drives.
(And the Maxtor SCSI drives kick that thing's ass... internal rate of
 350-622Mb/s for a sustained throughput of 33-55MB/s.  Expensive but
 much much faster.)

>> PS: I once turned down a 360MHz Ultra10 in favor of a 167MHz Ultra1 because
>>     of the absolutely shitty IDE performance.  The U1 was actually faster
>>     at compiling software. (Solaris 2.6, btw)
>
>yeah, if Sun can't make IDE scream, then no one can eh?

Linux wasn't any freakin' better at it.  (Sun's IDE still seriously sucks.)

--Ricky


