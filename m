Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261519AbSJDHaO>; Fri, 4 Oct 2002 03:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbSJDHaN>; Fri, 4 Oct 2002 03:30:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:25250 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261519AbSJDHaN>;
	Fri, 4 Oct 2002 03:30:13 -0400
Date: Fri, 4 Oct 2002 09:46:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] kernel/sched.c oddness?
In-Reply-To: <3D9CB35D.90503@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210040945290.7007-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Oct 2002, Matthew Dobson wrote:

> /* It needs an at least ~50% imbalance to trigger balancing. */
> 
> Either way works for me.  I'd like to see something done, as the
> comments don't match the code right now...

the patch looks good to me - i'll add it to my next scheduler patchset,
after some testing on bigger SMP boxes. Balancing tends to be a very
volatile area.

	Ingo

