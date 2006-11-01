Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946913AbWKAQG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946913AbWKAQG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946824AbWKAQG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:06:29 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1006 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423941AbWKAQG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:06:28 -0500
Date: Wed, 1 Nov 2006 17:05:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061101160551.GA2598@elf.ucw.cz>
References: <1154985aa0591036@2ka.mipt.ru> <1162380963981@2ka.mipt.ru> <20061101130614.GB7195@atrey.karlin.mff.cuni.cz> <20061101132506.GA6433@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101132506.GA6433@2ka.mipt.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Generic event handling mechanism.
> > > 
> > > Consider for inclusion.
> > > 
> > > Changes from 'take21' patchset:
> > 
> > We are not interrested in how many times you spammed us, nor we want
> > to know what was wrong in previous versions. It would be nice to have
> > short summary of what this is good for, instead.
> 
> Let me guess, short explaination in subsequent emails is not
> enough...

Yes.

> Kevent is a generic subsytem which allows to handle event notifications.
> It supports both level and edge triggered events. It is similar to
> poll/epoll in some cases, but it is more scalable, it is faster and
> allows to work with essentially eny kind of events.

Quantifying "how much more scalable" would be nice, as would be some
example where it is useful. ("It makes my webserver twice as fast on
monster 64-cpu box").

> Events are provided into kernel through control syscall and can be read
> back through mmaped ring or syscall.
> Kevent update (i.e. readiness switching) happens directly from internals
> of the appropriate state machine of the underlying subsytem (like
> network, filesystem, timer or any other).
> 
> I will put that text into introduction message.

Thanks.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
