Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTLQDDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 22:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTLQDDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 22:03:31 -0500
Received: from b1.ovh.net ([213.186.33.51]:2735 "EHLO mail9.ha.ovh.net")
	by vger.kernel.org with ESMTP id S262176AbTLQDDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 22:03:30 -0500
Message-ID: <1071630228.3fdfc794eb353@ssl0.ovh.net>
Date: Wed, 17 Dec 2003 04:03:48 +0100
From: Miroslaw KLABA <totoro@totoro.be>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Double Interrupt with HT
References: <20031215155843.210107b6.totoro@totoro.be>  <1071603069.991.194.camel@cog.beaverton.ibm.com>  <1071615336.3fdf8d6840208@ssl0.ovh.net> <1071618630.1013.11.camel@cog.beaverton.ibm.com>
In-Reply-To: <1071618630.1013.11.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 81.250.170.171
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Ok, so its been around awhile. Do you remember what was the last 2.4
> kernel where you did not see this problem?
> 

In fact, it is a new motherboard we're testing, and with the oldest version of
the kernel I have, 2.4.18, I have also the problem.

> Further I can't see how it fixes the problem, but it may just be working
> around the issue. I'd be interested in what the patch author thinks. 
> 
> > I think it is a bug with the via chipset, but I'm not able to get deeper in
> the
> > kernel code.
> 
> Could be, but I suspect interrupt routing isn't happening properly at
> boot time. The irqbalance code just forces it to be readjusted correctly
> once your up and running. 
> 

With SMP disabled, I have no problem with any kernel. So it must be in the APIC
init, I think.
I don't know how the patch works around this problem, but it's a workaround. I
can test other kernels to find a "better" patch to find and fix this problem,
and have a stable 2.4.24 that works with this hardware.
If you can suggest other things to test or to identify the problem, I can do it.

Thanks
Miro
