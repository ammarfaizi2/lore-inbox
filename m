Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbTCLH6j>; Wed, 12 Mar 2003 02:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263082AbTCLH6j>; Wed, 12 Mar 2003 02:58:39 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:44588 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S263080AbTCLH6i>; Wed, 12 Mar 2003 02:58:38 -0500
Date: Wed, 12 Mar 2003 09:02:08 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Richard Henderson <rth@twiddle.net>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <20030311235223.A30856@twiddle.net>
Message-ID: <Pine.LNX.4.30.0303120848040.17121-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Mar 2003, Richard Henderson wrote:
> On Wed, Mar 12, 2003 at 07:07:26AM +0100, Szakacsits Szabolcs wrote:
> > Only way I see is to detect it at build time, BIG warning to the user
> > of compiler, print a well visible "kernel was built by broken tools"
> > message at boot time to end users ...
>
> You don't have to let things go that far.  If you have a test
> case,

gcc team must have, haven't it? Do you know?

> then you can run the test case at build time, and have
> the make actively fail.  So the kernel never gets built at all.

I thought about it, I'm just afraid too much kernel wouldn't build.
This bug is in most 2.95, 2.96 and according to Alan in 3.0 and early
3.1) and people would just start "working around" it by commenting out
the check for getting something to work quickly then forgetting about
the issue completely.

	Szaka

