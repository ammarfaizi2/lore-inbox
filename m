Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbREVX7l>; Tue, 22 May 2001 19:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262903AbREVX7b>; Tue, 22 May 2001 19:59:31 -0400
Received: from tpau.muc.eurocyber.net ([195.143.108.12]:60945 "EHLO
	tpau.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S262901AbREVX7U>; Tue, 22 May 2001 19:59:20 -0400
Message-ID: <3B0AFCFB.CAE7A145@teraport.de>
Date: Wed, 23 May 2001 01:57:47 +0200
From: Martin Knoblauch <martin.knoblauch@teraport.de>
Organization: Teraport GmbH
X-Mailer: Mozilla 4.6 [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <3B0A28C0.2FFFC935@TeraPort.de> <3B0A3794.15BDF9D6@TeraPort.de> <3B0A99E7.467CE534@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> "Martin.Knoblauch" wrote:
> >
> >  After some checking, I could have made the answer a bit less terse:
> >
> > - it would require that the kernel is compiled with cpuid [module]
> > support
> >   - not everybody may want enable this, just for getting one or two
> >     harmless numbers.
> 
> If so, then that's their problem.  We're not here to solve the problem of
> stupid system administrators.
>

 They may not be stupid, just mislead :-( When Intel created the "cpuid"
Feature some way along the P3 line, they gave a stupid reason for it and
created a big public uproar. As silly as I think that was (on both
sides), the term "cpuid" is tainted. Some people just fear it like hell.
Anyway.
 
> > - you would need a utility with root permission to analyze the cpuid
> > info. The
> >   cahce info does not seem to be there in clear ascii.
> 
> Bullsh*t.  /dev/cpu/%d/cpuid is supposed to be mode 444 (world readable.)
> 

 Thanks you :-) In any case, on my system (Suse 7.1) the files are mode
400.

Martin
