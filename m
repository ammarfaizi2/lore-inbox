Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbSI3VmX>; Mon, 30 Sep 2002 17:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbSI3VmX>; Mon, 30 Sep 2002 17:42:23 -0400
Received: from dsl092-148-080.wdc1.dsl.speakeasy.net ([66.92.148.80]:25289
	"EHLO tyan.doghouse.com") by vger.kernel.org with ESMTP
	id <S261342AbSI3VmV>; Mon, 30 Sep 2002 17:42:21 -0400
Date: Mon, 30 Sep 2002 17:47:45 -0400 (EDT)
From: Maxwell Spangler <maxwax@speakeasy.net>
X-X-Sender: <maxwell@tyan.doghouse.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: AMD 768 erratum 10 (solved: AMD 760MPX DMA lockup)
In-Reply-To: <20020927084601.C25704@fi.muni.cz>
Message-ID: <Pine.LNX.4.33.0209301746350.10704-100000@tyan.doghouse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does this mouse have to be actively used...

Could one plug a cheap ps/2 mouse into that port and yet continue to use a USB 
mouse if X is configured to use it?

What is actually happening that causes the ps/2 mouse to cure this or any 
other problem of this nature?

Curious.

On Fri, 27 Sep 2002, Jan Kasprzak wrote:

> Manfred Spraul wrote:
> : The errata is not PS/2 mouse specific:
> : it says that the io apic doesn't implement masking interrupts correctly.
> 
> 	Yes, but it says that problem has not been observed when running
> with PS/2 mouse. Which is exactly what I observe on my system.
> : 
> : Linux uses masking aggressively - disable_irq() is implemented by 
> : masking the interrupt in the io apic. I'm surprised that this doesn't 
> : cause frequent problems.
> 
> 	The errata does not say that the interrupt masking in the IO-APIC
> does not work in all situations. I read it as the lock-up (caused by
> nonfunctional IRQ masking) sometimes occurs, nobody knows when,
> and it has been observed on some Netware boxes w/o the PS/2 mouse.
> Maybe even AMD does not know exactly what is going on there.
> 
> : Regarding Jan's problem: I'm not sure if his problems are related to 
> : this errata. It says that using a PS/2 mouse instead of a serial mouse 
> : with Novell Netward avoids the hang during shutdown, probably because 
> : then netware doesn't mask the irq.
> 
> 	Yes, it may be a faulty board as well, but I think it is
> too close to this AMD errata.
> 
> -Yenya
> 
> -- 
> | Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
> | GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
> | http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> |----------- If you want the holes in your knowledge showing up -----------|
> |----------- try teaching someone.                  -- Alan Cox -----------|
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- ----------------------------------------------------------------------------
Maxwell Spangler                                                
Program Writer                                              
Greenbelt, Maryland, U.S.A.                         
Washington D.C. Metropolitan Area 

