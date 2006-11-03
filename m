Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753193AbWKCJNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbWKCJNr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 04:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbWKCJNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 04:13:47 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:6584 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1753193AbWKCJNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 04:13:45 -0500
Date: Fri, 3 Nov 2006 12:13:02 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nate Diller <nate.diller@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Oleg Verych <olecom@flower.upol.cz>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061103091301.GC1184@2ka.mipt.ru>
References: <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz> <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com> <20061102062158.GC5552@2ka.mipt.ru> <5c49b0ed0611021140u360342f2v1e83c73d03eea329@mail.gmail.com> <20061103084240.GB1184@2ka.mipt.ru> <20061103085712.GA3725@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061103085712.GA3725@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 03 Nov 2006 12:13:04 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 09:57:12AM +0100, Pavel Machek (pavel@ucw.cz) wrote:
> > So, kqueue API and structures can not be usd in Linux.
> 
> Not sure what you are smoking, but "there's unsigned long in *bsd
> version, lets rewrite it from scratch" sounds like very bad idea. What
> about fixing that one bit you don't like?

It is not about what I dislike, but about what is broken or not.
Putting u64 instead of a long or some kind of that _is_ incompatible
already, so why should we even use it?
And, btw, what we are talking about? Is it about the whole kevent
compared to kqueue in kernelspace, or just about what structure is being
transferred between kernelspace and userspace?
I'm sure, it was some kind of a joke to 'not rewrite *bsd from scratch
and use kqueue in Linux kernel as is'.

> 								Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
	Evgeniy Polyakov
