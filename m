Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbUCLXBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUCLXBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:01:46 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:49412 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263012AbUCLXBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:01:44 -0500
Date: Sat, 13 Mar 2004 02:01:41 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-ID: <20040313020141.B4021@den.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch> <20040312182754.A680@jurassic.park.msu.ru> <20040312184115.B680@jurassic.park.msu.ru> <20040312165907.626d4a08@hdg.gigerstyle.ch> <20040312224649.A750@den.park.msu.ru> <20040312215215.1041889a@hdg.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040312215215.1041889a@hdg.gigerstyle.ch>; from gigerstyle@gmx.ch on Fri, Mar 12, 2004 at 09:52:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 09:52:15PM +0100, Marc Giger wrote:
> Right now I'm recompiling the kernel. So you say this patch isn't a fix
> but a test? 

Yes. That patch just reverts new alpha semaphore stuff which went
into 2.6.4.

> This time I have additionally "semaphore debugging" enabled,
> perhaps it's useful for you.

Thanks, this might be helpful.

> > The answer is here:
> > http://bugzilla.kernel.org/show_bug.cgi?id=397
> 
> That's no answer, that's a statement:-) Do know the exactly reason why
> it should be a bad idea? Is it mostly a bad idea on alpha?

Hmm, I haven't discussed that with Richard, so I can't speak for him :-)
IMHO, the benefits of the kernel preempt support in general are more than
doubtful, the level of complexity that it adds to the kernel code is
just unacceptable.

Ivan.
