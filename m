Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319071AbSHMUtA>; Tue, 13 Aug 2002 16:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319072AbSHMUtA>; Tue, 13 Aug 2002 16:49:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8108 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319071AbSHMUs6>;
	Tue, 13 Aug 2002 16:48:58 -0400
Date: Tue, 13 Aug 2002 22:53:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] user-vm-unlock-2.5.31-A1
In-Reply-To: <Pine.LNX.4.44.0208132243230.12317-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208132252250.12463-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> note that a quick testing did not show the desired result yet, so there
> must be some thinko in it, but this is how i think it would roughly look
> like. The copy_thread() code takes a pointer away from the user-stack -
> userspace should put the lock there.

it was a flaw in the testing code, after fixing it the user-vm-unlock
works as expected.

	Ingo

