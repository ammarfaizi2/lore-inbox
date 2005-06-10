Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVFJWNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVFJWNz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVFJWNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:13:55 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:51209 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261276AbVFJWNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:13:53 -0400
Date: Fri, 10 Jun 2005 15:19:14 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610221914.GA20694@nietzsche.lynx.com>
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <1118436338.6423.48.camel@mindpipe> <20050610210614.GD6564@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610210614.GD6564@g5.random>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 11:06:14PM +0200, Andrea Arcangeli wrote:
> On Fri, Jun 10, 2005 at 04:45:38PM -0400, Lee Revell wrote:
> > AFAICT even RTAI would be affected, because X lets userspace drivers
> > talk directly to the hardware including wedging the PCI bus.
> 
> Yes, I made the usb example exactly to show how latency bugs can be
> longstanding in the kernel too without requiring X or hardware bugs
> (this usb thing breaks kernel latency for years and yet nobody fixed it
> simply because it just works fine in practice, I noticed because

...

That's because it puts much more stress on the Linux kernel than before.
It's going to take some time to log, audit and fix these issues, but
fixing them after discovery isn't really a big deal as you make it. The
hyperbole where drivers screw with latency is finite. This is a very
managable problem. Again, this a problem for all RTOS system and their
supporting drivers as well since they often come from BSD open source
community.

bill

