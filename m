Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbRCBQ1x>; Fri, 2 Mar 2001 11:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129305AbRCBQ1m>; Fri, 2 Mar 2001 11:27:42 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:12233 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S129300AbRCBQ12>;
	Fri, 2 Mar 2001 11:27:28 -0500
Date: Fri, 2 Mar 2001 17:22:57 +0100 (CET)
From: kees <kees@schoen.nl>
To: Ed Tomlinson <tomlins@cam.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.x system Freezes
In-Reply-To: <01030120171000.01156@oscar>
Message-ID: <Pine.LNX.4.21.0103021719150.26612-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I experience simular problems with 2.2.19(pre6) on a SMP machine at work.
Random lockups, tried removing SCSI adapter, sound card, replaced network
card all didn't help. My last action was replacing the videocard.....
Since then I havn't had any lockups, before they came at least once a day
but mostle almost every hour :-((

Mobo MSI 394D 2 x Copmin 677 MHz, 128 MB, no O.C. S3 video card.

regards

Kees


On Thu, 1 Mar 2001, Ed Tomlinson wrote:

> Hi,
> 
> A couple of weeks age I reported a couple of problems.  The first two turned 
> out not to be serious but the third, where the system freezes, has not 
> stopped happening.  Several other people have reported similar problems...
> 
> Typically my system will die while kde2.1 is starting (about 1 time in 4) or 
> shortly after I start a caching news server (newsplex), another common 
> trigger is dpkg, when reading its database just before it starts up unpack 
> packages.   If it gets thru these hurdles it may last up to three days - most 
> of the time I am luckly to get one...  
> 
> Once it hangs its really hung.  A ups cannot trigger a shutdown, sysrq is 
> dead, the num lock indicator will not toggle.  Trying to use shift, alt or 
> control + shiftlock does not result in any data on a serial console, nor are 
> there any unexpected messages there.   Also pinging from the box running the 
> serial console gets no answers during a stall.   The software watchdog does 
> not get triggered either.
> 
> I would love NOT to have to be such close friends with the reset button.  
> (reiserfs has been very usefully with all the crashes...)
> 
> I have install kdb on the off chance that I can hit PAUSE fast enought to it 
> to do a bt command one time it freezes.  What else can be done to debug this? 
> Could this be related to the memory problems reported reciently?
> 
> TIA
> Ed Tomlinson <tomlins@cam.org>
> 
> Current kernel is 2.4.2-ac7 + kdb 1.8
> K6-III 400 via mp3 128M
> mga400max AGP (x1) with xfree 4.02 driver
> SB16 ISA, nonpnp using alsa 5.10b drivers
> USR ISA modem, nonpnp
> Tuplip based card connected to an small internal 100BaseT network
> VIA Rhine based cards connected to a 10BaseT xDSL modem
> no scsi
> hda=13G hdb=4.3G (both quantum, UDMA2) hdc=CDROM hdd=tape (both ATAPI PIO)
> usb optical MS mouse
> My root filesystem is on reiserfs and reiserfsck tells me its fine when 
> booted from a recovery partition.
> 
> On Feb 6 Ed Tomlinson wrote:
> >System hangs.  This box has been quite stable.  The hangs started 
> >appearing around 2.4.1 or so.  I very much doubt they are heat releated.  I 
> >have had heat problems in the past an have moved the kit into a much better 
> >case.  The old symptoms (ide tape problems) have gone and not returned even 
> >on the hotest summer day...  Next time this happens I will try to telnet or 
> >ssh into box to see if anything is active, I will also setup a UPS on the 
> >box and see it that can shut it down.  Its interesting that the software 
> >watchdog does not get triggered.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

