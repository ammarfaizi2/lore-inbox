Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSCVOq0>; Fri, 22 Mar 2002 09:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312699AbSCVOqQ>; Fri, 22 Mar 2002 09:46:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312619AbSCVOqA>; Fri, 22 Mar 2002 09:46:00 -0500
Date: Fri, 22 Mar 2002 09:42:17 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Dave Jones <davej@suse.de>, Mikael Pettersson <mikpe@csd.uu.se>,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br, torvalds@transmeta.com
Subject: Re: [PATCH] boot_cpu_data corruption on SMP x86
In-Reply-To: <Pine.GSO.3.96.1020322145646.21326A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.3.95.1020322093549.371A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Maciej W. Rozycki wrote:

> On Fri, 22 Mar 2002, Dave Jones wrote:
> 
> >  > If say the BSP supports cpuid but an AP does not (possible for an
> >  > i486 setup)
> > 
> >  It's also possible on any SMP aware system, but with the warning
> 
>  Nope, anything that provides cpuid will update the model and the stepping
> correctly.
> 
> >  "you use asymetric CPUs, you get to keep the pieces". I don't recall
> >  486's being any exception to this rule.
> 
>  Cpuid vs non-cpuid is a non-issue for the i486 -- the glue logic is
> external as well as APICs and we don't care about the SMM, so no need to
> unsupport it explicitly. 
> 

FYI, the "fix" to make Windows/2000/Professional survive more than
a day before requiring a low-level format and re-install of everything,
was to remove the second CPU from a 2 - CPU system that ran for two
years without errors under Linux. Linux may have a race-or two, but
it certainly does a very good job with SMP, something that M$ will
apparently never do.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

