Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318922AbSH1TXz>; Wed, 28 Aug 2002 15:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318924AbSH1TXz>; Wed, 28 Aug 2002 15:23:55 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:29352 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318922AbSH1TXx>;
	Wed, 28 Aug 2002 15:23:53 -0400
Date: Wed, 28 Aug 2002 21:28:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Fr?d?ric L. W. Meunier" <0@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ECS K7S5A: IDE performance
Message-ID: <20020828212811.A20840@ucw.cz>
References: <20020828190650.GC16018@louise.pinerecords.com> <Pine.LNX.4.44.0208281611210.213-100000@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208281611210.213-100000@pervalidus.dyndns.org>; from 0@pervalidus.net on Wed, Aug 28, 2002 at 04:19:13PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 04:19:13PM -0300, Fr?d?ric L. W. Meunier wrote:
> On Wed, 28 Aug 2002, Tomas Szepe wrote:
> 
> > > I have an ECS K7S5A 3.1A. It works fine with 2.4.19. No
> > > corruption. Now I tested it with hdparm and:
> > >
> > > hdparm -tT /dev/hda
> > >
> > > /dev/hda:
> > >  Timing buffer-cache reads:   128 MB in  0.79 seconds =162.03 MB/sec
> > >  Timing buffered disk reads:  64 MB in  1.68 seconds = 38.10 MB/sec
> > >
> > > Only 38.10 ?
> >
> > How do you mean, only 38.10?
> 
> I just thought it'd be much more with an ATA100. I got more or
> less the same with my earlier motherboard, an ASUS A7APro, and
> without ATA66 - which would print a lot of CRC errors at boot
> time if enabled in the BIOS. The K7S5A doesn't print any and is
> rock solid.
> 
> Maybe running it at 100/133 (and not 100/100) decreases
> performance ? I read is somewhere. I have an Athlon 1000 (200)
> with 2x256Mb DDR PC2100.

No. The limit is the drive platter read speed.

-- 
Vojtech Pavlik
SuSE Labs
