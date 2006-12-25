Return-Path: <linux-kernel-owner+w=401wt.eu-S1754560AbWLYWy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbWLYWy4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 17:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbWLYWy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 17:54:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:51459 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754560AbWLYWyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 17:54:55 -0500
X-Authenticated: #20450766
Date: Mon, 25 Dec 2006 23:54:58 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mark Glines <mark@glines.org>
cc: linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  powerpc: linkstation uses uimage style zImages
In-Reply-To: <459046FE.9030008@glines.org>
Message-ID: <Pine.LNX.4.60.0612252349040.3424@poirot.grange>
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
 <fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no> <45902A6F.4000100@glines.org>
 <Pine.LNX.4.60.0612252128530.3424@poirot.grange> <459046FE.9030008@glines.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

Thanks for the patch. Are you actually going to test this kernel on a real 
hardware or just testing builds? If it is going to be a real life test, 
I'd be interested to know what exactly hardware, U-boot version, dts, and 
what results.

BTW, ack-ing your patch would be a bit easier if you sent it inline.

On Mon, 25 Dec 2006, Mark Glines wrote:

> Once I tracked down and installed a "mkimage" command (dependency needed by
> the WRAP line), my "make zImage" succeeded.  So, I hope you guys apply this.

...

> Signed-off-by: Mark Glines <mark@glines.org>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> --- linux-2.6.20-rc2/arch/powerpc/platforms/embedded6xx/Kconfig.orig	2006-12-24 19:13:49.000000000 -0800
> +++ linux-2.6.20-rc2/arch/powerpc/platforms/embedded6xx/Kconfig	2006-12-24 19:14:02.000000000 -0800
> @@ -79,6 +79,7 @@
>  	select MPIC
>  	select FSL_SOC
>  	select PPC_UDBG_16550 if SERIAL_8250
> +	select DEFAULT_UIMAGE
>  	help
>  	  Select LINKSTATION if configuring for one of PPC- (MPC8241)
>  	  based NAS systems from Buffalo Technology. So far only
