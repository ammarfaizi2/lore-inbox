Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTLTMab (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 07:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTLTMab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 07:30:31 -0500
Received: from mail1.cc.huji.ac.il ([132.64.1.17]:679 "EHLO
	mail1.cc.huji.ac.il") by vger.kernel.org with ESMTP id S263983AbTLTMaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 07:30:18 -0500
Date: Sat, 20 Dec 2003 14:30:16 +0200 (IST)
From: Voicu Liviu <pacman@mscc.huji.ac.il>
To: Craig Bradney <cbradney@zip.com.au>
Cc: Disconnect <lkml@sigkill.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] Nforce2 oops and occasional hang (tried the lockups patch,
 no difference)
In-Reply-To: <1071865339.9969.3.camel@athlonxp.bradney.info>
Message-ID: <Pine.LNX.4.44.0312201428270.17852-100000@pluto.mscc.huji.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003, Craig Bradney wrote:

> On Fri, 2003-12-19 at 18:24, Disconnect wrote:
> > On Thu, 2003-12-18 at 13:52, Disconnect wrote:
> > > memory/cpu timings.  (Even underclocked it to 133 and 1G with no
> > > change.)  So its unfortunately back on a stock 2.4.23-pre9 with
> > > noapic/noacpi. (It disables one of the sets of usb ports, as I recall,
> > > but it mostly works...)
> > 
> > Update: Underclocked from 1.8G to 1.2G (whups, meant to go down only
> > 2-300mhz) and its been vaguely stable for about 1.5 days.  I don't have
> > another week (yet..) to run it under its normal load and wait for a
> > crash, so what I'm going to do is:
> >  - Move the workload (web/mail/..) to a different machine so this one
> > can be down for an extended period
> >  - Replace the ram with new sticks (they arrived this morning)
> >  - Reclock everything to stock (1.83G cpu, 200mhz ram and verify the
> > timings from kingston)
> >  - Replace the video card
> >  - Memtest86 until it cries
> >  - If it passes, bonnie++ on the new drives
> >  - If that passes, usb/acpi/apic testing with the associated patches
> > 
> > Anyone still watching this?  Tips and suggestions on what else might be
> > useful/informative are more than welcome.  The tests above mostly
> > replicate what I did when building this box, and it passed them then..
> > 
> > Recap:
> >  Epox 8rda+ nforce2 mobo
I have Epox 8rda3+
> >  AMD Athlon XP 2500+ (Barton) 1.83G
same
> >  Kingston HyperX PC3200
corsair twinx 512 (2 stiks of 256)
> >  WD Caviar WD1200JB 8M/UDMA100
seagate
> >  Antec case w/ 350W AMD-certified PSU
black case (not something special)
My system works with 2.4 and 2.6 even overclocked to 10x190 (1900 Mhz)
Cheers

> > 
> > Oopses and occasional hangs, usually in do_generic_file_read, using
> > stock kernel.org 2.4.2x kernels.  Hardware passed testing (memtest86,
> > bonnie++) before I put Linux on it.
> 
> Does this not relate directly to the APIC/IOAPIC issues with 2.6 kernel
> and nforce chipset motherboards? 
> 
> Craig
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Liviu Voicu
Assistant Programmer and network support
Computation Center, Mount Scopus
Hebrew University of Jerusalem
Tel: 972(2)-5881253
E-mail: "Liviu Voicu"<pacman@mscc.huji.ac.il>

/**
 * cat /usr/src/linux/arch/i386/boot/bzImage > /dev/dsp
 * ( and the voice of God will be heard! )
 *
 */

Click here to see my GPG signature:
----------------------------------
	http://search.keyserver.net:11371/pks/lookup?template=netensearch%2Cnetennomatch%2Cnetenerror&search=pacman%40mscc.huji.ac.il&op=vindex&fingerprint=on&submit=Get+List

