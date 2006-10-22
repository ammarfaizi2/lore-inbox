Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750698AbWJVWDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbWJVWDO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWJVWDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:03:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:36224 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750698AbWJVWDN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:03:13 -0400
Subject: Re: PAE broken on Thinkpad
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200610220450.15824.ak@suse.de>
References: <1161472697.5528.6.camel@localhost.localdomain>
	 <p73mz7pm7lt.fsf@verdi.suse.de>
	 <1161484239.5528.8.camel@localhost.localdomain>
	 <200610220450.15824.ak@suse.de>
Content-Type: text/plain
Date: Sun, 22 Oct 2006 15:03:11 -0700
Message-Id: <1161554591.5918.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-22 at 04:50 +0200, Andi Kleen wrote:
> On Sunday 22 October 2006 04:30, john stultz wrote:
> > On Sun, 2006-10-22 at 04:01 +0200, Andi Kleen wrote:
> > > john stultz <johnstul@us.ibm.com> writes:
> > > 
> > > > Yea. So I know I probably shouldn't run a PAE kernel on my 1Gig laptop,
> > > > but in trying to do so I found it won't boot.
> > > 
> > > You don't say what version?
> > 
> > Sorry, the current -git.
> 
> Normally the early exception handler should print a backtrace, i wonder
> why that didn't work.
> 
> Can you change the
> 
> static int current_ypos = 25
> 
> in arch/x86_64/kernel/early_printk.c to
> 
> static int current_ypos = 0
> 
> and see if that displays the backtrace?

Unfortunately not. :( I just get those two lines up at the top of the
screen.

thanks
-john

