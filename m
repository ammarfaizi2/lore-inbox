Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVBYGpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVBYGpc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 01:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVBYGpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 01:45:32 -0500
Received: from smtp11.wanadoo.fr ([193.252.22.31]:52554 "EHLO
	smtp11.wanadoo.fr") by vger.kernel.org with ESMTP id S262630AbVBYGp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 01:45:28 -0500
X-ME-UUID: 20050225064527468.727621C00087@mwinf1107.wanadoo.fr
Date: Fri, 25 Feb 2005 07:36:09 +0100
To: Christian Kujau <evil@g-house.de>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Meelis Roos <mroos@linux.ee>,
       Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       Sven Hartge <hartge@ds9.gnuu.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah) PCI IRQ map
Message-ID: <20050225063609.GA21244@pegasos>
References: <20041206185416.GE7153@smtp.west.cox.net> <Pine.SOC.4.61.0502221031230.6097@math.ut.ee> <20050224074728.GA31434@pegasos> <Pine.SOC.4.61.0502241746450.21289@math.ut.ee> <20050224160657.GB11197@pegasos> <421E7033.1030600@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <421E7033.1030600@g-house.de>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 01:24:19AM +0100, Christian Kujau wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Sven Luther wrote:
> > 
> > Oh, damn, need to fix my daily builder, should be ok for tomorrow. IN the
> > meanwhile, you can try : 
> > 
> >   http://people.debian.org/~luther/d-i/images/2005-02-23/powerpc/netboot/vmlinuz-prep.initrd
> 
> oh, what fun - it's booting! de4x5 is loading (although i build my kernels
> with a (compiled in) tulip driver). sym53c8xx gets loaded and initializing
> the scsi bus is *not* blocking all other activities as usual.
> 
> here are the logs:
> 
> http://nerdbynature.de/bits/hal/d-i-2005.02.23/  (working 2.6.8 from Sven)
> http://nerdbynature.de/bits/hal/2.6.11-rc3/      (scsi errors)
> 
> (note: i still have no disks attached)

So, now, we need to find out what the problems where, i think it is something
that went in between 2.6.8 and 2.6.10, and leigh said he had some ideas. Leigh
can you elaborate on those ? 

Friendly,

Sven Luther

