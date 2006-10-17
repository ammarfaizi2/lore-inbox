Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWJQQp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWJQQp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWJQQp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:45:57 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:55260 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751302AbWJQQpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:45:55 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take19 1/4] kevent: Core files.
Date: Tue, 17 Oct 2006 18:45:54 +0200
User-Agent: KMail/1.9.5
Cc: Johann Borck <johann.borck@densedata.com>,
       Ulrich Drepper <drepper@redhat.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
References: <11587449471424@2ka.mipt.ru> <200610171826.05028.dada1@cosmosbay.com> <20061017163536.GA17692@2ka.mipt.ru>
In-Reply-To: <20061017163536.GA17692@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610171845.54719.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 18:35, Evgeniy Polyakov wrote:
> On Tue, Oct 17, 2006 at 06:26:04PM +0200, Eric Dumazet (dada1@cosmosbay.com) 
wrote:
> > On Tuesday 17 October 2006 18:01, Evgeniy Polyakov wrote:
> > > Ok, there is one apologist for mmap buffer implementation, who forced
> > > me to create first implementation, which was dropped due to absense of
> > > remote mental reading abilities.
> > > Ulrich, does above approach sound good for you?
> > > I actually do not want to reimplement something, that will be
> > > pointed to with words 'no matter what you say, it is broken and I do
> > > not want it' again :).
> >
> > In my humble opinion, you should first write a 'real application', to
> > show how the mmap buffer and kevent syscalls would be used (fast path and
> > slow/recovery paths). I am sure it would be easier for everybody to agree
> > on the API *before* you start coding a *lot* of hard (kernel) stuff : It
> > would certainly save your mental CPU cycles (and ours too :) )
> >
> > This 'real application' could be  the event loop of a simple HTTP server,
> > or a basic 'echo all' server. Adding the bits about timers events and
> > signals should be done too.
>
> I wrote one with previous ring buffer implementation - it used timers
> and echoed when they fired, it was even described in details in one of the
> lwn.net articles.
>
> I'm not going to waste others and my time implementing feature requests
> without at least _some_ feedback from those who asked them.
> In case when person, originally requested some feature, does not answer
> and there are other opinions, only they will be get into account of
> course.

I am not sure I understand what you wrote, English is not our native language.

I think many people gave you feedbacks. I feel that all feedback on this 
mailing list is constructive. Many posts/patches on this list are never 
commented at all.

Eric
