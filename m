Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbQKGWdX>; Tue, 7 Nov 2000 17:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQKGWdN>; Tue, 7 Nov 2000 17:33:13 -0500
Received: from jalon.able.es ([212.97.163.2]:46514 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129486AbQKGWcy>;
	Tue, 7 Nov 2000 17:32:54 -0500
Date: Tue, 7 Nov 2000 23:32:47 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: continuing VM madness
Message-ID: <20001107233247.B1150@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <3A086B18.8B403C3F@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A086B18.8B403C3F@holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Tue, Nov 07, 2000 at 21:50:32 +0100
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Nov 2000 21:50:32 Michael Rothwell wrote:
> Should kswapd and klogd ever get "do_try_to_free_pages failed"? when
> this happens my machine is destabilized, and pauses briefly from time to
> time before locking up or otherwise becoming inert. This is 2.2.16+USB.
> 
> Nov  7 14:51:36 cartman kernel: VM: do_try_to_free_pages failed for
> kswapd... 
> Nov  7 15:46:39 cartman kernel: VM: do_try_to_free_pages failed for
> panel... 

That seems to be the place for Andrea Arcangeli VM patch. Get it at:

http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.16/mm-fix-*

Or even better, get kernel 2.2.17 and
http://www.kernel.org/pub/linux/kernel/people/alan/2.2.18pre/pre-patch-2.2.18-18.bz2
http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre18/VM-global-2.2.18pre18-7.bz2

and get a 2.2.18-pre18-vm, with USB support included.

There is a 2.2.18-pre20 out, but I have not still checked if
VM-global-2.2.18pre18-7.bz2
works on it. It worked for me in -pre19.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
