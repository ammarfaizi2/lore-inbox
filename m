Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287743AbSAFGJx>; Sun, 6 Jan 2002 01:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287744AbSAFGJn>; Sun, 6 Jan 2002 01:09:43 -0500
Received: from ns01.netrox.net ([64.118.231.130]:2757 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S287743AbSAFGJb>;
	Sun, 6 Jan 2002 01:09:31 -0500
Subject: Re: [patch] O(1) scheduler, 2.4.17-B0, 2.5.2-pre8-B0.
From: Robert Love <rml@tech9.net>
To: listmail@majere.epithna.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201052232170.13672-100000@majere.epithna.com>
In-Reply-To: <Pine.LNX.4.33.0201052232170.13672-100000@majere.epithna.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 06 Jan 2002 01:10:20 -0500
Message-Id: <1010297456.3226.11.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-05 at 22:34, listmail@majere.epithna.com wrote:
> How close are you and Robert Love on getting this patch and his pre-emt
> patches to co-operate...seems like that might bring huge wins.  I know, I
> know I could diff, and fix the rejects myself, but this seems to deep in
> the kernel for a relative newbie like myself(plus I am more a file system
> guy)

Unfortunately it looks like it is going to take a bit more than fixing
trivial rejects.  I started working on it today.  I suspect I am going
to need a lot better understanding of Ingo's scheduler, so I am learning
it.  I am traveling tomorrow but should be able to dive into it on
Monday.

Ingo and I both agree that the patches together are a Good Thing.

I have a fully ported patch at this point but it hard locks on boot.  I
believe the problem to be a few bits in sched.c, but there may be some
underlying changes that break assumptions elsewhere.

We are working on it.  Help is always appreciated, though ;)

	Robert Love

