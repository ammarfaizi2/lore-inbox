Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319083AbSHSW30>; Mon, 19 Aug 2002 18:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319084AbSHSW3Z>; Mon, 19 Aug 2002 18:29:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15571 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319083AbSHSW3Z>;
	Mon, 19 Aug 2002 18:29:25 -0400
Date: Tue, 20 Aug 2002 00:34:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <200208192231.g7JMVQI28575@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Richard Gooch wrote:

> Are you saying that people running libc 5 or even glibc 2.1 will
> suddenly have their code broken?

nope. Only if they use the 16-bit PID stuff in SysV IPC semaphores and
message queues.

	Ingo

