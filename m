Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289277AbSA2Mij>; Tue, 29 Jan 2002 07:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289629AbSA2MhB>; Tue, 29 Jan 2002 07:37:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:43721 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289645AbSA2MgC>;
	Tue, 29 Jan 2002 07:36:02 -0500
Date: Tue, 29 Jan 2002 15:33:34 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <3C568C52.2060707@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0201291527310.5560-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Martin Dalecki wrote:

> >One "patch penguin" scales no better than I do. In fact, I will claim
> >that most of them scale a whole lot worse.

> Bla bla bla... Just tell how frequenty do I have to tell the world,
> that the read_ahead array is a write only variable inside the kernel
> and therefore not used at all?????!!!!!!!!!!

tell Jens. He goes about fixing it all, not just the most visible pieces
that showed how much the Linux block IO code sucked. And guess what? His
patches are being accepted, and the Linux 2.5 block IO code is evolving
rapidly. Sometimes keeping broken code around as an incentive to fix it
*for real* is better than trying to massage the broken code somewhat.

a patch penguin doesnt solve this particular problem, by definition he
just wont fix the block IO code.

any other 'examples'?

	Ingo

