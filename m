Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262917AbREWASm>; Tue, 22 May 2001 20:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262918AbREWASc>; Tue, 22 May 2001 20:18:32 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:21008 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262917AbREWAS1>; Tue, 22 May 2001 20:18:27 -0400
Date: Wed, 23 May 2001 02:18:25 +0200 (CEST)
From: Tomas Telensky <ttel5535@ss1000.ms.mff.cuni.cz>
Reply-To: ttel5535@artax.karlin.mff.cuni.cz
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Martin Knoblauch <martin.knoblauch@teraport.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <3B0AFEC8.CDBF6C92@transmeta.com>
Message-ID: <Pine.LNX.4.21.0105230212050.14816-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 May 2001, H. Peter Anvin wrote:

> Martin Knoblauch wrote:
> > >
> > > If so, then that's their problem.  We're not here to solve the problem of
> > > stupid system administrators.
> > >
> > 
> >  They may not be stupid, just mislead :-( When Intel created the "cpuid"
> > Feature some way along the P3 line, they gave a stupid reason for it and
> > created a big public uproar. As silly as I think that was (on both
> > sides), the term "cpuid" is tainted. Some people just fear it like hell.
> > Anyway.
> > 
> 
> Ummm... CPUID has been around since the P5, and even if you have one with
> the serial-number feature, Linux disables it. 
> 
> > > > - you would need a utility with root permission to analyze the cpuid
> > > > info. The
> > > >   cahce info does not seem to be there in clear ascii.
> > >
> > > Bullsh*t.  /dev/cpu/%d/cpuid is supposed to be mode 444 (world readable.)
> > >
> > 
> >  Thanks you :-) In any case, on my system (Suse 7.1) the files are mode
> > 400.
> > 
> 
> It's pointless since you can execute CPUID directly in user space.  The

Yes. Recently I tried to transform whole cpuid code to a userspace
utility. Not easy, not clean... but it worked.

	Tomas

P.S.: but I still find the patch useful.

> device is there just to support CPU selection in a multiprocessor system.


