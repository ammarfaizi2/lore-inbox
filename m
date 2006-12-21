Return-Path: <linux-kernel-owner+w=401wt.eu-S1422959AbWLUOIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422959AbWLUOIw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422956AbWLUOIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:08:51 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:54320 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422951AbWLUOIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:08:50 -0500
Date: Thu, 21 Dec 2006 17:04:30 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: jamal <hadi@cyberus.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take28-resend_1->0 0/8] kevent: Generic event handling mechanism.
Message-ID: <20061221140429.GA25214@2ka.mipt.ru>
References: <3154985aa0591036@2ka.mipt.ru> <11666924573643@2ka.mipt.ru> <20061221103539.GA4099@2ka.mipt.ru> <458A64E5.4050703@garzik.org> <20061221104918.GA16744@2ka.mipt.ru> <1166708885.3749.49.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1166708885.3749.49.camel@localhost>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 21 Dec 2006 17:04:31 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 08:48:05AM -0500, jamal (hadi@cyberus.ca) wrote:
> Evgeniy,
> 
> On Thu, 2006-21-12 at 13:49 +0300, Evgeniy Polyakov wrote:
> 
> > So comment on its bugs, its design, implementation, ask questions,
> > request features, show interest (even with 'I have no time right now,
> > but will loko at it after in a week after vacations').
> > 
> > No one does it, so no one cares, so my behaviour.
> > 
> 
> Please dont be discouraged by lack of attention - you are doing good
> work.
> 
> I will concur with Jeff's point that since you are putting out a
> profound conceptual changes, and there are many stake holders, it
> requires scrutiny on their part. You need to build consensus in such a
> situation. 
> Some things that would help progress and build momentum:
> - As i have advised you before, why dont you modify something like
> existing libraries such as some of the loop thingies of desktop managers
> such as kde/gnome or better things like libevent etc. Then write your
> app on top of that? nobody is gonna run your httpd but if you
> demonstrate that libevent is much better with your changes (with zero
> changes to apps), people will migrate
> - from a user space angle if people like Ulrich would state their views
> on the current version you have. 
> Note, they dont have to agree with you i.e the conclusion could be a
> simple "agree to disagree".
> - There really oughta be a limit on how long people are allowed to be
> silent. After that IMO your code should just go in ...

I modified world-wide used web server lighttpd and ran a lot of tests
with it (compared to epoll version with major performance win).

I was asked yesterday by Jan Kneschke (lighttpd main developer) if
kevent API is ready so he could include my patch into mainline lighttpd 
tree, but I answered 'I do not know if kevent will be or not included, 
everyone keeps silence'.

I just do not know _what_ else should be done not even for inclusion - 
but at least for some progress.

You want libevent to be patched? Its site is currently down, but ok, I
will create a patch.

> cheers,
> jamal

-- 
	Evgeniy Polyakov
