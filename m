Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271105AbSISPJR>; Thu, 19 Sep 2002 11:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271141AbSISPJR>; Thu, 19 Sep 2002 11:09:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58791 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S271105AbSISPJP>;
	Thu, 19 Sep 2002 11:09:15 -0400
Date: Thu, 19 Sep 2002 17:21:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209190809020.3759-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209191720300.9746-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Sep 2002, Linus Torvalds wrote:

> However, what I worry about is that there may not (will not) be a 1:1
> session<->tty thing. In particular, when somebody creates a new session
> with "setsid()", that does not remove the tty from processes that used
> to hold it, I think (this is all from memory, so I might be wrong).

i've done the testrun with the p->tty == tty && p->session != tty->session
check, and it never triggers. (Which means nothing, but at least the
assumption is not trivially wrong.)

	Ingo

