Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261843AbRE3S61>; Wed, 30 May 2001 14:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbRE3S6R>; Wed, 30 May 2001 14:58:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29472 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261843AbRE3S6G>; Wed, 30 May 2001 14:58:06 -0400
Date: Wed, 30 May 2001 20:57:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mark Hemment <markhe@veritas.com>, Jens Axboe <axboe@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, cut three
Message-ID: <20010530205708.E25242@athlon.random>
In-Reply-To: <20010530162607.D1408@athlon.random> <Pine.LNX.4.21.0105301542210.12540-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105301542210.12540-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Wed, May 30, 2001 at 03:42:51PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 03:42:51PM -0300, Rik van Riel wrote:
> On Wed, 30 May 2001 andrea@e-mind.com wrote:
> 
> > btw, I think such heuristic is horribly broken ;), the highmem zone
> > simply needs to be balanced if it is under the pages_low mark, just
> > skipping it and falling back into the normal zone that happens to be
> > above the low mark is the wrong thing to do.
> 
> 2.3.51 did this, we all know the result.

I've no idea about what 2.3.51 does, but I was obviously wrong about
that. Forget such what I said above.

Andrea
