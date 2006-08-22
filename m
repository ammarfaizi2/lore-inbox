Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWHVW7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWHVW7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 18:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWHVW7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 18:59:22 -0400
Received: from alnrmhc14.comcast.net ([204.127.225.94]:36772 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751181AbWHVW7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 18:59:21 -0400
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: Nicholas Miell <nmiell@comcast.net>
To: David Miller <davem@davemloft.net>
Cc: jmorris@namei.org, johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org,
       drepper@redhat.com, akpm@osdl.org, netdev@vger.kernel.org,
       zach.brown@oracle.com, hch@infradead.org
In-Reply-To: <20060822.142500.11271092.davem@davemloft.net>
References: <1156276823.2476.22.camel@entropy>
	 <20060822.133606.48392664.davem@davemloft.net>
	 <1156281220.2476.65.camel@entropy>
	 <20060822.142500.11271092.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 15:58:31 -0700
Message-Id: <1156287511.2476.137.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 14:25 -0700, David Miller wrote:
> From: Nicholas Miell <nmiell@comcast.net>
> Date: Tue, 22 Aug 2006 14:13:40 -0700
> 
> > And how is the quality of the work to be judged if the work isn't
> > commented, documented and explained, especially the userland-visible
> > parts that *cannot* *ever* *be* *changed* *or* *removed* once they're in
> > a stable kernel release?
> 
> Are you even willing to look at the collection of example applications
> Evgeniy wrote against this API?
> 
> That is the true test of a set of interfaces, what happens when you
> try to actually use them in real programs.
> 
> Everything else is fluff, including standards and "documentation".
> 
> He even bothered to benchmark things, and post assosciated graphs and
> performance analysis during the course of development.

I wasn't aware that any of these existed, he didn't mention them in this
patch series. Having now looked, all I've managed to find are a series
of simple example apps that no longer work because of API changes.

Also, if you've been paying attention, you'll note that I've never
criticized the performance or quality of the underlying kevent
implementation -- as best I can tell, aside from some lockdep complaints
(which, afaik, are the result of lockdep's limitations rather than
problems with kevent), the internals of kevent are excellent.

-- 
Nicholas Miell <nmiell@comcast.net>

