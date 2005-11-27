Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVK0OL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVK0OL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 09:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbVK0OL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 09:11:57 -0500
Received: from mail.suse.de ([195.135.220.2]:57034 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751066AbVK0OL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 09:11:56 -0500
Date: Sun, 27 Nov 2005 15:11:55 +0100
From: Andi Kleen <ak@suse.de>
To: Ren? Rebe <rene@exactcode.de>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] x86_64: Test patch for ATI/Nvidia timer problems
Message-ID: <20051127141155.GI20775@brahms.suse.de>
References: <20051126142030.GA26449@wotan.suse.de> <200511271014.53217.rene@exactcode.de> <20051127135325.GG20775@brahms.suse.de> <200511271502.18782.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511271502.18782.rene@exactcode.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 03:02:13PM +0100, Ren? Rebe wrote:
> Hi,
> 
> On Sunday 27 November 2005 14:53, Andi Kleen wrote:
> > On Sun, Nov 27, 2005 at 10:14:53AM +0100, Ren? Rebe wrote:
> > > Hi,
> > > 
> > > On Saturday 26 November 2005 15:20, Andi Kleen wrote:
> > > > Everybody who saw timing problems with ATI IXP based boards with x86-64
> > > > or some Nvidia NForce4 boards please test this patch. Please send
> > > > success/failure to me.
> > > 
> > > I try to give your patch a try on the ATI based MSI Megabook S270, today - 
> > > however even with the workaround of "noapic" I had timer drift on resuem from 
> > > ram if the cpu was scaled to a lower frequency when it was suspended.
> > 
> > But it worked properly before suspend/resume without noapic? 
> 
> Without noapic the timer has about the 2x speed compared to real-time. I
> only used the machien with noapic since otherwise it is barely useful.

It has that still with the patch applied? The patch was supposed
to fix that at least part of that problem on ATI systems
(there seems to be also a timer miscalibration problem on some other
laptops) 

-Andi
