Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVEMTQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVEMTQD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVEMTOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:14:55 -0400
Received: from colin.muc.de ([193.149.48.1]:8967 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262487AbVEMTII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:08:08 -0400
Date: 13 May 2005 21:08:07 +0200
Date: Fri, 13 May 2005 21:08:07 +0200
From: Andi Kleen <ak@muc.de>
To: Scott Robert Ladd <lkml@coyotegulch.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513190807.GC47131@muc.de>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009347.1448.489.camel@localhost.localdomain> <4284F6B5.2080308@coyotegulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4284F6B5.2080308@coyotegulch.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 02:49:25PM -0400, Scott Robert Ladd wrote:
> Alan Cox wrote:
> > HT for most users is pretty irrelevant, its a neat idea but the
> > benchmarks don't suggest its too big a hit
> 
> On real-world applications, I haven't seen HT boost performance by more
> than 15% on a Pentium 4 -- and the usual gain is around 5%, if anything
> at all. HT is a nice idea, but I don't enable it on my systems.

I saw better improvement in some cases.  It always depends on the workload.
And on the generation of HT (there are three around). And lots of other
factors.

Even for your workload only it does not seem to me to be very rational
to throw away a 15% speedup with open eyes.

-Andi
