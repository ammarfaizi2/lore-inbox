Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261725AbTCGSrK>; Fri, 7 Mar 2003 13:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbTCGSrK>; Fri, 7 Mar 2003 13:47:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8455 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261725AbTCGSrI>; Fri, 7 Mar 2003 13:47:08 -0500
Date: Fri, 7 Mar 2003 10:55:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
In-Reply-To: <Pine.LNX.4.44.0303071949160.16478-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303071052490.1606-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Ingo Molnar wrote:
> 
> hm. Could you then please just re-test the -A6 patch with the same base
> tree again? I'd like to make sure that it _is_ the -A6 => -B0 delta that
> causes this considerable level of improvement for you.

Side note: current BK has the -B2 thing without the non-core changes (ie
no WAKER_BONUS_RATIO, and no sysctl stuff, and some reorg of the code due
to the dropping of the WAKER_BONUS_RATIO).

Ingo, you might want to double-check that you agree that my reorg is
equivalent.

		Linus

