Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290377AbSBKU6l>; Mon, 11 Feb 2002 15:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290421AbSBKU6b>; Mon, 11 Feb 2002 15:58:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59398 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290377AbSBKU60>; Mon, 11 Feb 2002 15:58:26 -0500
Date: Mon, 11 Feb 2002 15:57:22 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Francois Romieu <romieu@cogenit.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with mke2fs on huge RAID-partition
In-Reply-To: <20020211195710.A12859@fafner.intra.cogenit.fr>
Message-ID: <Pine.LNX.3.96.1020211155518.1149A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, Francois Romieu wrote:

> Bill Davidsen <davidsen@tmr.com> :
> [hdparm]
> > NOTE: wrong options will hose your data! WHich is why I don't tell you
> > what to use, just look at -m -c (I use 3), -d and -X34. Again, it may bite
> > you, have backups.
> 
> The kernel did itself the job through the "autotune" option of ide.
> /proc/ide/{hda/hdg}/settings differ only in:

> It can be fast: it does during raid rebuild.
> May be the machine simply dislikes me.

What's your stripe size? I have that "this works for me" feeling, although
I'd like to know why the drives didn't autotune just the same way, and
that might tell someone what's up.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

