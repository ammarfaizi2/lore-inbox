Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbVL2Ash@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVL2Ash (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVL2Ash
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:48:37 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38613 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964943AbVL2Asg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:48:36 -0500
Subject: Re: 2.6.15-rc5: latency regression vs 2.6.14 in
	exit_mmap->free_pgtables
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 19:54:15 -0500
Message-Id: <1135817656.4645.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 22:59 +0000, Hugh Dickins wrote:
> Here's an untested patch which should mostly correct your latency
> problem with 2.6.15-rc.  But it's certainly not the right solution,
> and it's probably both too ugly and too late for 2.6.15.  If you
> really want Linus to put it in, please test it out, especially on
> ia64, and try to persuade him.  Personally I'd prefer to wait for
> the right solution: but I don't have your low-latency needs, and
> I'm certainly guilty of a regression here.

OK, FWIW the patch does work.

It occurred to me that this might only be a noticeable latency
regression on slower machines.  Although too late for 2.6.15 it would be
nice to have fixed for 2.6.16...

Lee

