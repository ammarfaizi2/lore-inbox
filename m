Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262109AbSIYUZU>; Wed, 25 Sep 2002 16:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262117AbSIYUZU>; Wed, 25 Sep 2002 16:25:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57247 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262109AbSIYUZT>;
	Wed, 25 Sep 2002 16:25:19 -0400
Date: Wed, 25 Sep 2002 22:39:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] exit-fix-2.5.38-E3
In-Reply-To: <20020925201338.GA32366@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209252239090.21095-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Daniel Jacobowitz wrote:

> Could you check TASK_ZOMBIE and TASK_DEAD explicitly, or add a comment
> in sched.h saying that only DEAD should be above ZOMBIE?  Otherwise, if
> someone needs a new task state, this'll get out of sync.

i'll add a comment.

	Ingo

