Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313763AbSDPQg4>; Tue, 16 Apr 2002 12:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313764AbSDPQgz>; Tue, 16 Apr 2002 12:36:55 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22775
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313763AbSDPQgy>; Tue, 16 Apr 2002 12:36:54 -0400
Date: Tue, 16 Apr 2002 09:39:20 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <20020416163920.GB23513@matchmail.com>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204151400200.13034-100000@penguin.transmeta.com> <Pine.LNX.4.33.0204151415110.15353-100000@penguin.transmeta.com> <20020415232058.GO21206@holomorphy.com> <20020416024458.H26561@dualathlon.random> <20020416013016.GA23513@matchmail.com> <20020416154418.B25328@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 03:44:18PM +0200, Andrea Arcangeli wrote:
> On Mon, Apr 15, 2002 at 06:30:16PM -0700, Mike Fedyk wrote:
> > under testing.  Also, Andrew found a problem with your locking changes when
> > he split up your patch, and at the time you were saying it is ready and
> > there were no bug reports against in...
> 
> btw, it was a problem only for ext3.
>

Right, I forgot to mention that.

> > Does this patch conflict in any way with your vm patches?  If not they
> > should be able to co-exist.
> 
> it will generate rejects, but that's not the problem. My point is that
> your same argument about merging in later kernels, stable kernel tree,
> could be applied to patches that makes no difference to users too.
> 

True.  Has Rik's cleanup already been merged into 2.5?

> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
