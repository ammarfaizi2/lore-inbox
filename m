Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751692AbWGZPCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbWGZPCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWGZPCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:02:04 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12440 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751692AbWGZPCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:02:03 -0400
Date: Wed, 26 Jul 2006 17:00:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: David Lang <dlang@digitalinsight.com>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
Message-ID: <20060726150041.GG23701@stusta.de>
References: <20060725034247.GA5837@kroah.com> <200607261510.03098.adq_dvb@lidskialf.net> <20060726142932.GE23701@stusta.de> <200607261539.50492.adq_dvb@lidskialf.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607261539.50492.adq_dvb@lidskialf.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 03:39:49PM +0100, Andrew de Quincey wrote:
> On Wednesday 26 July 2006 15:29, Adrian Bunk wrote:
>...
> > The real problem is:
> > How do we get some testing coverage of -stable kernels by users to catch
> > issues?
> > And compile errors are the least of my worries.
> 
> Yeah - I believe some people did test the DVB -stable patches, but obviously 
> without the budget-av driver compile option enabled, so it didn't compile 
> that code. DVB supports quite a few cards, so its easy to accidentally leave 
> off one of the options when doing a mass compile of all drivers.
> 
> The only thing I can think of would be to require -stable patch submitters to 
> supply a list of CONFIG options that must be on to enable compilation of the 
> new code so people know exactly how to enable it for testing... but obviously 
> since those would be manually specified, they can be wrong too. But at least 
> it would show they'd thought about it a bit....

This helps only with compilation errors, which are as I said the least 
of my worries.

But does the hardware driven by this driver work?
And if it does, is there a bug in the patch that causes the kernel to 
crash after some hours?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

