Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288568AbSADJbV>; Fri, 4 Jan 2002 04:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288567AbSADJbR>; Fri, 4 Jan 2002 04:31:17 -0500
Received: from relativity.phy.olemiss.edu ([130.74.16.250]:44224 "EHLO
	relativity.phy.olemiss.edu") by vger.kernel.org with ESMTP
	id <S288568AbSADJbF>; Fri, 4 Jan 2002 04:31:05 -0500
Date: Fri, 4 Jan 2002 01:31:04 -0800
From: Chris Lawrence <quango@watervalley.net>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
Message-ID: <20020104093104.GB522@phy.olemiss.edu>
Mail-Followup-To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
In-Reply-To: <E16MGPf-0001I3-00@the-village.bc.nu> <Pine.GSO.4.21.0201041009000.12102-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0201041009000.12102-100000@vervain.sonytel.be>
User-Agent: Mutt/1.3.24i
Organization: The University of Mississippi (Standard Disclaimer Applies)
X-Operating-System: Linux/i686 2.4.12-ac3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 04, Geert Uytterhoeven wrote:
> On Thu, 3 Jan 2002, Alan Cox wrote:
> > > Is the hdx=bswap or hdx=swapdata option actually in use?
> > > When is it needed?
> > 
> > Certain M68K machines
> > 
> > > The current implementation can cause data corruptions on SMP with PIO 
> > > transfers:
> > > 
> > > Is it possible to remove the option entirely, or should it be fixed?
> > 
> > Show me an SMP Atari ST 8)
> 
> IIRC it's used to access non-Atari IDE disks on Atari (which has a byte-swapped
> IDE interface) and vice-versa.
> 
> So yes, you can use it on SMP machines, to access disks that were used before
> on Atari.

The byteswapping flags are also used by people hacking TiVos; the
non-MIPS models have byte-swapped IDE interfaces, and so the bswap
flag is needed to mount a TiVo disk on a PC.


Chris
-- 
Chris Lawrence <cnlawren@olemiss.edu> - http://www.lordsutch.com/chris/

Instructor and Ph.D. Candidate, Political Science, Univ. of Mississippi
208 Deupree Hall - 662-915-5765
