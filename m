Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318170AbSIOSbP>; Sun, 15 Sep 2002 14:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318173AbSIOSbP>; Sun, 15 Sep 2002 14:31:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35485 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318170AbSIOSbO>;
	Sun, 15 Sep 2002 14:31:14 -0400
Date: Sun, 15 Sep 2002 20:42:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-exec-2.5.34-B1, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209151128580.10830-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209152041310.9731-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Sep 2002, Linus Torvalds wrote:

> I don't personally much like the POSIX execve() behaviour, and I'd like
> to make sure that it can be avoided for cases where that makes sense (ie
> a threaded app that wants to start some other helper program should be
> able to do so).

i dont like those semantics either - will verify whether thread-specific
exec() works via a helper thread (or vfork) - it really should.

	Ingo

