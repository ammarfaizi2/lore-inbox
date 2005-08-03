Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVHCJHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVHCJHE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 05:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVHCJHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 05:07:04 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:4293 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262164AbVHCJHC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 05:07:02 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 3 Aug 2005 02:06:47 -0700
From: Tony Lindgren <tony@atomide.com>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] no-idle-hz aka dynamic ticks
Message-ID: <20050803090646.GF5406@atomide.com>
References: <200508022225.31429.kernel@kolivas.org> <20050803085910.A29066@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803085910.A29066@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King <rmk+lkml@arm.linux.org.uk> [050803 00:59]:
> On Tue, Aug 02, 2005 at 10:25:26PM +1000, Con Kolivas wrote:
> > As promised, here is an updated patch for the newly released 2.6.13-rc5.
> > Boots and runs fine on P4HT (SMP+SMT kernel) built with gcc 4.0.1.
> 
> Please note that ARM already has dyn-tick merged in mainline.  If
> we're going to be adding dyn-tick for x86, please do it in a way
> that we don't create another goddamned awful mess like we did for
> the ARM IRQ stuff.

I agree, and will be working on that :)

> I notice that this version does some things in a different way to
> the ARM version - for instance, it doesn't pass the "number of
> jiffies to skip" to the arch reprogram function.

I've been meaning to update the x86 stuff with the changes we did for
ARM as soon as I have some time.

Tony
