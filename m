Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSGSTOm>; Fri, 19 Jul 2002 15:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSGSTOm>; Fri, 19 Jul 2002 15:14:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14283 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315293AbSGSTOl>;
	Fri, 19 Jul 2002 15:14:41 -0400
Date: Sat, 20 Jul 2002 21:15:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: mgross <mgross@unix-os.sc.intel.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
Subject: Re: [PATCH]: scheduler complex macros fixes
In-Reply-To: <200207191745.g6JHjBP00767@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.44.0207202113460.20609-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jul 2002, mgross wrote:

> Thats too bad.  I've been looking at Ingo's SCHED_BATCH design to help
> suspend processes with out lock problems while doing multithreaded core
> dumps.
> 
> Is there any ETA on the return path to user mode clean up?

oh, there's no fundamental problem here, i'm doing the return-path-cleanup
patch too :-) [which, as a side-effect, also removes the global irq lock.]
I temporarily suspended it for the sake of the SCHED_BATCH feature and
other scheduler maintainance work. But it just got higher priority, so ...

	Ingo

