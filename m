Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318638AbSHPR1S>; Fri, 16 Aug 2002 13:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318641AbSHPR1S>; Fri, 16 Aug 2002 13:27:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13072 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318638AbSHPR1S>; Fri, 16 Aug 2002 13:27:18 -0400
Date: Fri, 16 Aug 2002 10:34:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
In-Reply-To: <Pine.LNX.4.44.0208161921060.17613-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208161033090.3193-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Ingo Molnar wrote:
> 
> having looked at threading libraries i can tell you that any library
> writer who cares about performance would use a futex for exit
> notification.

Oh, good. If it turns out that even pthreads wants the futex, let's just
do it that way. Pls send in a patch once you have something tested ready,
ok?

Much cleaner.

		Linus

