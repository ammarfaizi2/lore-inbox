Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbREZX0Z>; Sat, 26 May 2001 19:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbREZXYW>; Sat, 26 May 2001 19:24:22 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262569AbREZW6x>;
	Sat, 26 May 2001 18:58:53 -0400
Date: Sat, 26 May 2001 17:03:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526170306.X9634@athlon.random>
In-Reply-To: <20010526163233.U9634@athlon.random> <Pine.LNX.4.21.0105261135200.30264-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105261135200.30264-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sat, May 26, 2001 at 11:36:22AM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 11:36:22AM -0300, Rik van Riel wrote:
> On Sat, 26 May 2001, Andrea Arcangeli wrote:
> > > No Comment(tm)   *grin*
> > 
> > I'm having lots of fun, thanks.
> 
> Now _this_ is tweaking magic limits ;)

Others agreed that the real source of the create_buffers could be just
too few reserved pages in the unused_list, the unused_list is the only
"deadlock avoidance logic" designed to avoid create_buffers to deadlock,
so I really don't see why you don't listen to me and you just assume my
idea is obviously wrong while it obviously isn't. The only thing I can
do is to laugh while reading your illogical "No Comment(tm)   *grin*",
if I would take such comment serously I would just ignore the VM and
stay in other subsystem where those funny things never happens as far I
can tell, which I'm not going to do just because of your new funny "No
Comment(tm) *grin*". If for any reason you notice I somehow invite those
things to happen please let me know and I will certainly try to get
better from my part.

Andrea
