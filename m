Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313440AbSDPAq2>; Mon, 15 Apr 2002 20:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313442AbSDPAq1>; Mon, 15 Apr 2002 20:46:27 -0400
Received: from [195.223.140.120] ([195.223.140.120]:17488 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313440AbSDPAq0>; Mon, 15 Apr 2002 20:46:26 -0400
Date: Tue, 16 Apr 2002 02:44:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <20020416024458.H26561@dualathlon.random>
In-Reply-To: <Pine.LNX.4.33.0204151400200.13034-100000@penguin.transmeta.com> <Pine.LNX.4.33.0204151415110.15353-100000@penguin.transmeta.com> <20020415232058.GO21206@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 04:20:58PM -0700, William Lee Irwin III wrote:
> I won't scream too loud, but I think it's pretty much done right as is.

Regardless if that's the cleaner implementation or not, I don't see much
the point of merging those cleanups in 2.4 right now: it won't make any
functional difference to users and it's only a self contained code
cleanup, while other patches that make a runtime difference aren't
merged yet.

Andrea
