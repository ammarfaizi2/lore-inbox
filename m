Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317790AbSHOXm5>; Thu, 15 Aug 2002 19:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317799AbSHOXm5>; Thu, 15 Aug 2002 19:42:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44720 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317790AbSHOXm4>;
	Thu, 15 Aug 2002 19:42:56 -0400
Date: Fri, 16 Aug 2002 01:47:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208151643380.15744-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208160146480.6252-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Linus Torvalds wrote:

> A thread library - maybe not. But the SETTID thing makes sense even for
> a fork() user to avoid the fork/SIGCHLD race condition. In contrast, a
> CLRTID does _not_ make sense in that situation, so I actually think they
> are two separate issues (and should thus be two separate bits).

we could skip the 'clear' bit if this is the last release of the mm.

	Ingo

