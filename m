Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270134AbRISSrN>; Wed, 19 Sep 2001 14:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272736AbRISSrE>; Wed, 19 Sep 2001 14:47:04 -0400
Received: from [195.223.140.107] ([195.223.140.107]:8432 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S270134AbRISSq6>;
	Wed, 19 Sep 2001 14:46:58 -0400
Date: Wed, 19 Sep 2001 20:47:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010919204720.L720@athlon.random>
In-Reply-To: <andrea@suse.de> <6663.1000923993@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6663.1000923993@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Wed, Sep 19, 2001 at 07:26:33PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 07:26:33PM +0100, David Howells wrote:
> > if we go generic then I strongly recommend my version of the generic
> > semaphores is _much_ faster (and cleaner) than this one
> 
> Not so:-) Your patch, Andrea, grabs the spinlock far more than is necessary.

then why your microbenchmarks says my version is much faster?

Andrea
