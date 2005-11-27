Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVK0Nx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVK0Nx1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 08:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVK0Nx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 08:53:27 -0500
Received: from cantor2.suse.de ([195.135.220.15]:27105 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751052AbVK0Nx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 08:53:26 -0500
Date: Sun, 27 Nov 2005 14:53:25 +0100
From: Andi Kleen <ak@suse.de>
To: Ren? Rebe <rene@exactcode.de>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] x86_64: Test patch for ATI/Nvidia timer problems
Message-ID: <20051127135325.GG20775@brahms.suse.de>
References: <20051126142030.GA26449@wotan.suse.de> <200511271014.53217.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511271014.53217.rene@exactcode.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 10:14:53AM +0100, Ren? Rebe wrote:
> Hi,
> 
> On Saturday 26 November 2005 15:20, Andi Kleen wrote:
> > Everybody who saw timing problems with ATI IXP based boards with x86-64
> > or some Nvidia NForce4 boards please test this patch. Please send
> > success/failure to me.
> 
> I try to give your patch a try on the ATI based MSI Megabook S270, today - 
> however even with the workaround of "noapic" I had timer drift on resuem from 
> ram if the cpu was scaled to a lower frequency when it was suspended.

But it worked properly before suspend/resume without noapic? 

-Andi

