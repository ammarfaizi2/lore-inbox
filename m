Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbREZW7G>; Sat, 26 May 2001 18:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbREZW65>; Sat, 26 May 2001 18:58:57 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261968AbREZW6q>;
	Sat, 26 May 2001 18:58:46 -0400
Date: Sat, 26 May 2001 14:11:15 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526171459.Y9634@athlon.random>
Message-ID: <Pine.LNX.4.33.0105261409370.9587-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> not being able to reproduce has nothing to do with a deadlock fixed or
> not. Also Ben's patch I think was claiming to fix the deadlock and it
> didn't even addressed the create_bounces that it is fixed in 2.4.5.

No.  It does not fix the deadlock.  Neither does the patch you posted.
But, if you're going to add a reserve pool for buffer heads and bounce
pages, please do it with generic, not yet another special case hack.

		-ben

