Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273859AbRIRFsj>; Tue, 18 Sep 2001 01:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273861AbRIRFsT>; Tue, 18 Sep 2001 01:48:19 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:57142 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273859AbRIRFsL>; Tue, 18 Sep 2001 01:48:11 -0400
Date: Tue, 18 Sep 2001 07:48:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918074834.H698@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109171608310.1108-100000@penguin.transmeta.com> <20010917211834.A31693@redhat.com> <20010918035055.J698@athlon.random> <20010917221653.B31693@redhat.com> <20010918052201.N698@athlon.random> <20010918000132.C885@redhat.com> <20010918063910.U698@athlon.random> <20010918012216.C1249@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010918012216.C1249@redhat.com>; from bcrl@redhat.com on Tue, Sep 18, 2001 at 01:22:16AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 01:22:16AM -0400, Benjamin LaHaise wrote:
> That's where I want 2.4 to get to.

yes, me too, we agree. And what I faced is that I couldn't do that
without first removing the broken mess. It wasn't possible to just make
a two liner to fix it.

> So why not split that fix out as a seperate patch that can then be applied 
> alone?

It's not as simple as it seems, I noticed such a bug in the middle of
the developement and so it was controversial to fix, I should have fixed
the same bug first in the new VM then in the old vm, only the
free_pages_ok change would been non controversial but such one alone
would been useless since it wouldn't be self contained. so I did it for
my vm and I never ended splitting it off because it was non trivial work.

> Thanks!  I think we'll all be a bit calmer in the morning and better able to 

never mind.

> think clearly.  I'll even try to break things down a bit as there are bits 
> in your patches which I think are very good.

Great, thanks!

Andrea
