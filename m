Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbVLQMg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbVLQMg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 07:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVLQMg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 07:36:59 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:38359 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932572AbVLQMg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 07:36:58 -0500
Date: Sat, 17 Dec 2005 07:36:50 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-Reply-To: <43A3C461.2030900@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0512170731271.12362@gandalf.stny.rr.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com> 
 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
 <1134791914.13138.167.camel@localhost.localdomain> <43A3C461.2030900@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Dec 2005, Nick Piggin wrote:

> Steven Rostedt wrote:
> > On Fri, 2005-12-16 at 23:13 +0000, David Howells wrote:
>
> >>This patch set does the following:
> >>
> >> (1) Renames DECLARE_MUTEX and DECLARE_MUTEX_LOCKED to be DECLARE_SEM_MUTEX and
> >>     DECLARE_SEM_MUTEX_LOCKED for counting semaphores.
> >>
> >
> >
> > Could we really get rid of that "MUTEX" part.  A counting semaphore is
> > _not_ a mutex, although a mutex _is_ a counting semaphore.  As is a Jack
> > Russell is a dog, but a dog is not a Jack Russell.
> >
>
> Really?
>
> A Jack Russell is a dog because anything you say about a dog can
> also be said about a Jack Russell.

I said a Jack Russell _is_ a dog, but a dog is not a Jack Russell.
Everything you can say about a dog you can't say about a Jack Russell.
Since, a dog can have other characteristics than a Jack Russell has. A dog
can be big and lazy, but I would not say that about a Jack Russell.

>
> A counting semaphore is a mutex for the same reason (and observe
> that 99% of users use the semaphore as a mutex). A mutex definitely
> is not a counting semaphore. David's implementation of mutexes
> don't count at all.

But a counting semaphore of (one) _is_ a mutex!  But a mutex can't have
more than one.   As for David's code, that's just arguing implementation,
and not the semantics of it.

-- Steve

