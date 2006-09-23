Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWIWE0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWIWE0N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 00:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWIWE0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 00:26:13 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:47250 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750807AbWIWE0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 00:26:12 -0400
Date: Sat, 23 Sep 2006 08:23:50 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-ID: <20060923042350.GA24099@2ka.mipt.ru>
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru> <20060922122207.3b716028.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060922122207.3b716028.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 23 Sep 2006 08:23:52 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 12:22:07PM -0700, Andrew Morton (akpm@osdl.org) wrote:
> On Wed, 20 Sep 2006 13:35:47 +0400
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > Generic event handling mechanism.
> > 
> > Consider for inclusion.
> 
> Ulrich's objections sounded substantial, and afaik remain largely
> unresolved.   How do we sort this out?

There are no objections, but request for additional interface.

The only two things missed in patchset after his suggestions are
new POSIX-like interface, which I personally consider as very unconvenient,
but in any way it can be implemented as addon, and signal mask change,
but Ulrich have not answered how does it differ from blocking in
userspace and then calling appropriate syscall, I expect the difference
is only in reduced number of syscalls.

-- 
	Evgeniy Polyakov
