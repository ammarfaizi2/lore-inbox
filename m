Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274274AbRISXq7>; Wed, 19 Sep 2001 19:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274286AbRISXqt>; Wed, 19 Sep 2001 19:46:49 -0400
Received: from [195.223.140.107] ([195.223.140.107]:46577 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274284AbRISXqe>;
	Wed, 19 Sep 2001 19:46:34 -0400
Date: Thu, 20 Sep 2001 01:46:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010920014648.F720@athlon.random>
In-Reply-To: <andrea@suse.de> <7486.1000941940@warthog.cambridge.redhat.com> <20010920013421.D720@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010920013421.D720@athlon.random>; from andrea@suse.de on Thu, Sep 20, 2001 at 01:34:21AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 01:34:21AM +0200, Andrea Arcangeli wrote:
> On Thu, Sep 20, 2001 at 12:25:40AM +0100, David Howells wrote:
> > 
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > > On Wed, Sep 19, 2001 at 07:26:33PM +0100, David Howells wrote:
> > > > > if we go generic then I strongly recommend my version of the generic
> > > > > semaphores is _much_ faster (and cleaner) than this one
> > > >
> > > > Not so:-) Your patch, Andrea, grabs the spinlock far more than is necessary.
> > > 
> > > then why your microbenchmarks says my version is much faster?
> > 
> > They don't:
> 
> ok, so I drop my objections, you must have changed something radical

hey no! It was a very unfair comparison! my rwsem are non inlined, yours
are.

Andrea
