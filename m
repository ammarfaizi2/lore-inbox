Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313680AbSDPNoN>; Tue, 16 Apr 2002 09:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313679AbSDPNoM>; Tue, 16 Apr 2002 09:44:12 -0400
Received: from [195.223.140.120] ([195.223.140.120]:56370 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313680AbSDPNoL>; Tue, 16 Apr 2002 09:44:11 -0400
Date: Tue, 16 Apr 2002 15:44:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <20020416154418.B25328@dualathlon.random>
In-Reply-To: <Pine.LNX.4.33.0204151400200.13034-100000@penguin.transmeta.com> <Pine.LNX.4.33.0204151415110.15353-100000@penguin.transmeta.com> <20020415232058.GO21206@holomorphy.com> <20020416024458.H26561@dualathlon.random> <20020416013016.GA23513@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 06:30:16PM -0700, Mike Fedyk wrote:
> under testing.  Also, Andrew found a problem with your locking changes when
> he split up your patch, and at the time you were saying it is ready and
> there were no bug reports against in...

btw, it was a problem only for ext3.

> Does this patch conflict in any way with your vm patches?  If not they
> should be able to co-exist.

it will generate rejects, but that's not the problem. My point is that
your same argument about merging in later kernels, stable kernel tree,
could be applied to patches that makes no difference to users too.

Andrea
