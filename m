Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbTATWBc>; Mon, 20 Jan 2003 17:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267372AbTATWBc>; Mon, 20 Jan 2003 17:01:32 -0500
Received: from mx2.elte.hu ([157.181.151.9]:13258 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267361AbTATWBb>;
	Mon, 20 Jan 2003 17:01:31 -0500
Date: Mon, 20 Jan 2003 23:16:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.59-D7
In-Reply-To: <3E2C713E.2050301@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0301202315260.20530-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Jan 2003, Manfred Spraul wrote:

> > 	if (do_wakeup) {
> >-		wake_up_interruptible(PIPE_WAIT(*inode));
> >+		wake_up_interruptible_sync(PIPE_WAIT(*inode));

> What's the purpose of this change?

It was a quick experiment i forgot to remove from my sources, will fix it
in the next patch.

	Ingo

