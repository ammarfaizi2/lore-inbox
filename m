Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKHQ7M>; Wed, 8 Nov 2000 11:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKHQ7C>; Wed, 8 Nov 2000 11:59:02 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:10756 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129061AbQKHQ7A>; Wed, 8 Nov 2000 11:59:00 -0500
Date: Wed, 8 Nov 2000 17:58:53 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: continuing VM madness
In-Reply-To: <20001107233247.B1150@werewolf.able.es>
Message-ID: <Pine.LNX.3.96.1001108174731.7153B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Should kswapd and klogd ever get "do_try_to_free_pages failed"? when
> > this happens my machine is destabilized, and pauses briefly from time to
> > time before locking up or otherwise becoming inert. This is 2.2.16+USB.
> > 
> > Nov  7 14:51:36 cartman kernel: VM: do_try_to_free_pages failed for
> > kswapd... 
> > Nov  7 15:46:39 cartman kernel: VM: do_try_to_free_pages failed for
> > panel... 
> 
> That seems to be the place for Andrea Arcangeli VM patch. Get it at:
> 
> http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.16/mm-fix-*
> 
> Or even better, get kernel 2.2.17 and
> http://www.kernel.org/pub/linux/kernel/people/alan/2.2.18pre/pre-patch-2.2.18-18.bz2
> http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre18/VM-global-2.2.18pre18-7.bz2
> 
> and get a 2.2.18-pre18-vm, with USB support included.
> 
> There is a 2.2.18-pre20 out, but I have not still checked if
> VM-global-2.2.18pre18-7.bz2
> works on it. It worked for me in -pre19.

Sadly it is not a bug but a VM misdesign (and people are just making
different workarounds that more or less work). I believe that this
solution will break again, as it happened in 2.2.15 and 2.2.16.

Go back to Linux 2.0 - it has the swapper implemented correctly :-)

Mikulas


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
