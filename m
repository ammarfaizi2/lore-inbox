Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289042AbSAIWIl>; Wed, 9 Jan 2002 17:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289044AbSAIWId>; Wed, 9 Jan 2002 17:08:33 -0500
Received: from fysh.org ([212.47.68.126]:25363 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S289042AbSAIWIW>;
	Wed, 9 Jan 2002 17:08:22 -0500
Date: Wed, 9 Jan 2002 22:08:21 +0000
From: Athanasius <Athanasius@gurus.tf>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon XP 1600+ and _mmx_memcpy symbol in modules
Message-ID: <20020109220821.GJ15688@gurus.tf>
Mail-Followup-To: Athanasius <Athanasius@gurus.tf>, arjan@fenrus.demon.nl,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020109182224.GI15688@gurus.tf> <m16OO2K-000OVeC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m16OO2K-000OVeC@amadeus.home.nl>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 07:05:20PM +0000, arjan@fenrus.demon.nl wrote:
> In article <20020109182224.GI15688@gurus.tf> you wrote:
> > Hi,
> >  I've just upraded from my old PII-400 system to an Athlon XP 1600+
> > based system so changed from "Pentium-Pro/Celeron/Pentium-II"
> > (CONFIG_M686) to "Athlon/Duron/K7" (CONFIG_MK7).  In doing so I suddenly
> > saw a LOT of problems with modules and the symbol _mmx_memcpy being
> > undefined.
> 
> >  I finally kludged/fixed this by changing line 121 of
> > arch/i386/kernel/i386_ksyms.c from:
> 
> > EXPORT_SYMBOL(_mmx_memcpy);
> 
> you forgot to make mrproper ;) (or at least make clean)
> yes the makefile for modversions is missing a dependency......

   I'll recheck with 'make mrproper' as I do always do a 'make clean'
(and dep for that matter) after changing configuration at all.

thanks,

-Ath
-- 
- Athanasius = Athanasius(at)gurus.tf / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
