Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSGSRPB>; Fri, 19 Jul 2002 13:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSGSRPB>; Fri, 19 Jul 2002 13:15:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37542 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316900AbSGSRPA>;
	Fri, 19 Jul 2002 13:15:00 -0400
Date: Sat, 20 Jul 2002 19:16:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH]: scheduler complex macros fixes
In-Reply-To: <200207191911.48427.efocht@ess.nec.de>
Message-ID: <Pine.LNX.4.44.0207201913400.17697-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jul 2002, Erich Focht wrote:

> Thanks. But as long as SCHED_BATCH ins't in 2.5.X, we need this separate
> fix. And if it's in the main tree, you don't need it additionally in
> your patches. The fix is O(1) specific and I thought it should not hide
> inside the SCHED_BATCH patches, some people might encounter these
> problems...

well, SCHED_BATCH is in fact ready, so we might as well put it in. All the
suggestions mentioned on lkml (or in private) are now included, there are
no pending (known) problems, no objections, and a number of people are
using it with success.

	Ingo

