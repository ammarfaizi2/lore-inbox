Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbVJUSJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVJUSJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVJUSJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:09:57 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:62903 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965054AbVJUSJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:09:56 -0400
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0510210157080.1946@localhost.localdomain>
References: <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain>
	 <20051020073416.GA28581@elte.hu>
	 <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
	 <20051020080107.GA31342@elte.hu>
	 <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain>
	 <20051020085955.GB2903@elte.hu>
	 <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
	 <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain>
	 <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain>
	 <1129826750.27168.163.camel@cog.beaverton.ibm.com>
	 <20051020193214.GA21613@elte.hu>
	 <Pine.LNX.4.58.0510210157080.1946@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 11:09:46 -0700
Message-Id: <1129918192.27168.218.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 02:03 -0400, Steven Rostedt wrote:
> With rc4-rt13 and changing cycle_t to u64, my machine ran all night
> without one backward step.  Since it use to show up after a couple of
> hours, I would say that this is the fix.

Great. I've committed that change to my tree already.


> John, Do you want me to take a crack at changing the periodic_hook into
> using the ktimer code?  I understand Ingo's kernel much more than you, but
> you definitely understand the timing code better than I.

If Thomas doesn't think its a good idea, then don't worry about it. I'd
be somewhat curious just how bad it is, but that can wait for now.

thanks
-john


