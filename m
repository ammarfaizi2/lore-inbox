Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290059AbSA3Qks>; Wed, 30 Jan 2002 11:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290063AbSA3Qjm>; Wed, 30 Jan 2002 11:39:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:60614 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290045AbSA3Qi0>;
	Wed, 30 Jan 2002 11:38:26 -0500
Date: Wed, 30 Jan 2002 19:35:03 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Larry McVoy <lm@bitmover.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130083254.H23269@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0201301933390.11022-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Larry McVoy wrote:

> How much of the out order stuff goes away if you could send changes
> out of order as long as they did not overlap (touch the same files)?

could this be made: 'as long as they do not touch the same lines of code,
taking 3 lines of context into account'? (ie. unified diff definition of
'collisions' context.)

	Ingo

