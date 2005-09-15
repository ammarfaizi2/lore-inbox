Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbVIOTXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVIOTXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbVIOTXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:23:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965196AbVIOTXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:23:38 -0400
Date: Thu, 15 Sep 2005 12:23:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: kumar.gala@freescale.com, mporter@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][MM] rapidio: message interface updates
Message-Id: <20050915122301.41da6fb3.akpm@osdl.org>
In-Reply-To: <20050915082451.A26921@cox.net>
References: <20050907081312.B1925@cox.net>
	<5322C997-A1FD-47BB-B92B-17CBA627EC53@freescale.com>
	<20050915082451.A26921@cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter <mporter@kernel.crashing.org> wrote:
>
> On Thu, Sep 15, 2005 at 10:05:43AM -0500, Kumar Gala wrote:
> > I'm guessing we are looking at a 2.6.15 timeframe now for getting the  
> > RapidIO subsystem in?  Are there any other changes beyond what is  
> > setting in -mm that need to be done?
> 
> Well, at least 2.6.15, 2.6.14 cutoff has passed.

Merging rapidio has negligible chance of breaking any existing kernel code,
but I suppose that to be good little kernel citizens we should await 2.6.15
if that's OK.

> We are waiting on
> a review of of the rionet updates I reposted a week ago. I've held
> off on going too far with MMIO and 8548 support since the last rionet
> changes required changes to the messaging support.

Jeff added the rionet driver to his tree and I dropped it from -mm, so
we're ready to go on that front.

