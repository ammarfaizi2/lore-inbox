Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbTACOyi>; Fri, 3 Jan 2003 09:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbTACOyh>; Fri, 3 Jan 2003 09:54:37 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59913 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267540AbTACOyg>; Fri, 3 Jan 2003 09:54:36 -0500
Date: Fri, 3 Jan 2003 10:00:53 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Aniruddha M Marathe <aniruddha.marathe@wipro.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [2.5.54] OOPS: unable to handle kernel paging request
In-Reply-To: <94F20261551DC141B6B559DC49108672044910@blr-m3-msg.wipro.com>
Message-ID: <Pine.LNX.3.96.1030103095913.25100C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2003, Aniruddha M Marathe wrote:

> >From: Paul Rolland [mailto:rol@as2917.net] 
> >Subject: Re: [2.5.54] OOPS: unable to handle kernel paging request
> >
> >
> >Got the same yesterday evening when installing 2.5.54 for the 
> >first time....
> >
> >My second PC which I used for Serial console was not at home, 
> >so if a console output is needed, people will have to wait for 
> >the weekend (which is not that far).
> >
> >Config was roughly including :
> > - Arch = P4, Unipro, APIC
> > - CPU Freq scaling
> > - ACPI (enum only)
> > - TCP (v4 + v6), Netfilter
> > - IDE, SCSI (AIC7xxx),
> > - Sound (Alsa, EMu10K1),
> > - Crypto
> >
> >This oops happens at the very early stage of the boot process. 
> >By that time, only 10 to 15 lines are displayed on the screen 
> >following the "Booting ...................." stuff.
> >
> >
> Check if the processor in your .config matches with the processor that you have.
> Eg. Problme might arise if .config file says CONFIG_MPENTIUMIII=y when your processor is P4.

Might, but I have the same thing, and I copied my 2.5.53 config and did
oldconfig. Got a perfect build, it just doesn't boot. The snow is falling,
I'm likely to have time to look at it this weekend.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

