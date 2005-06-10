Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVFJXKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVFJXKK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVFJXGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:06:39 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42547
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261399AbVFJXFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:05:18 -0400
Date: Sat, 11 Jun 2005 01:05:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bill Huey <bhuey@lnxw.com>
Cc: Lee Revell <rlrevell@joe-job.com>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610230510.GG6564@g5.random>
References: <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <1118436338.6423.48.camel@mindpipe> <20050610210614.GD6564@g5.random> <20050610221914.GA20694@nietzsche.lynx.com> <20050610223751.GE6564@g5.random> <20050610230121.GB21618@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610230121.GB21618@nietzsche.lynx.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 04:01:21PM -0700, Bill Huey wrote:
> LynxOS runs on HP printers for real time guarantees all of the time and
> is good for general purpose usages as well. Folks use single image kernel
> for RT guarantees even before the existence RTAI and RT Linux. Your history
> is reversed here. People have been doing this for ages under a single image.

I don't care what folks did for ages, I care what I think is best to do
_now_ with linux, and I don't see why one should go with RTOS when much
simpler and more reliable and _more_performant_ solutions exists when
switching to linux, even for the printers.

> Hard RT is required in audio. It's require in processing DSP data coming
> from those cards. ioctl() paths are short and pretty much directly go to

Those are sort of problems where metal-hard may be simpler to deal with,
if there's a skip they'll record a second time, and you can just use
measurement and proabability there, without providing any guarantee.

Perhaps you can't handle valid criticism cause you have a conflict of
interest.
