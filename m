Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSBDUIw>; Mon, 4 Feb 2002 15:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288092AbSBDUIm>; Mon, 4 Feb 2002 15:08:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5792 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288113AbSBDUIb>;
	Mon, 4 Feb 2002 15:08:31 -0500
Date: Mon, 4 Feb 2002 23:06:13 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: Ed Tomlinson <tomlins@cam.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <3C5EE8AE.1206EEEB@kolumbus.fi>
Message-ID: <Pine.LNX.4.33.0202042303240.16086-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Feb 2002, Jussi Laako wrote:

> My application is very good example of this kind of application. I'm
> very worried about the way new scheduler is beginning to behave. It's
> combination of single processes with many threads and many processes
> with single threads. [...]

please give it a test then (i'd suggest using the latest, -K2 patch) and
let me know about what you find - this way we can fix any possible real
problems instead of talking in hypotheticals.

	Ingo

