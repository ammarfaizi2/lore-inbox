Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSHUE7s>; Wed, 21 Aug 2002 00:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSHUE7r>; Wed, 21 Aug 2002 00:59:47 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:57248 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S317859AbSHUE7r>; Wed, 21 Aug 2002 00:59:47 -0400
Subject: Re: devfs
From: Ed Sweetman <safemode@speakeasy.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208210449.g7L4nBo23764@vindaloo.ras.ucalgary.ca>
References: <Pine.GSO.4.21.0208181852450.3920-100000@weyl.math.psu.edu>
	<1029712550.3331.43.camel@psuedomode> 
	<200208210449.g7L4nBo23764@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Aug 2002 01:03:52 -0400
Message-Id: <1029906233.14060.44.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 00:49, Richard Gooch wrote:
> It seems the reason you removed devfs is that you followed Al's bad
> advice:
> Alexander Viro writes:
> > Don't be silly - if you want to test anything, devfs is the last
> > thing you want on the system.
> 
> In fact, devfs works quite robustly for many people, and wasn't
> involved in the IDE problems you were having. Al is an absolutist: if
> it's not 100% provably correct, it falls into his other category,
> "spawn of satan".
> 
> So next time someone claims devfs is causing you problems, treat it
> with the skepticism it deserves.
> 
> 				Regards,
> 
> 					Richard....


Ok, well the more happy the people who have the ability to know what the
problem is the better so despite a simple usb issue, moving out of devfs
wasn't a hassle.  I'm willing to move back to vanilla if it helps in
chasing a problem down.  I'm just kind of disappointed that the
discussion of me playing around with devfs got more attention from the
ide guys than the actual problem since it seems to be strictly DMA
related and not a drive problem so if it's chipset conflicts it should
be documented either in the good-bad firmware so the kernel disables dma
on boot of this particular promise chipset when this particular via
chipset is present or in the HELP for the config option so at least
users are aware that drive corruption has been known to happen on the
linux promise driver when dma is enabled on some via chipsets.  That is
unless it's a fixable problem.  Which i rather hope it is.  neither the
abit motherboard or promise controller card are uncommon.   But since
nobody i know has via + promise setups I cant ask them to run the
cerberus test to see the same behavior to see the extent of the promise
+ via problems or if it's even got anything to do with via.  (shrugs)

