Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288256AbSA0Rbz>; Sun, 27 Jan 2002 12:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSA0Rbq>; Sun, 27 Jan 2002 12:31:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:41365 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288248AbSA0Rbh>;
	Sun, 27 Jan 2002 12:31:37 -0500
Date: Sun, 27 Jan 2002 20:29:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] [sched] avoid %fs/%gs reloading on x86.
In-Reply-To: <Pine.LNX.4.33.0201271817310.5713-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201272027570.7637-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Jan 2002, Ingo Molnar wrote:

> [...] On P6 class CPUs it takes 36 cycles to reload %fs and %gs, [...]

correction: 14 cycles.

> when applied to 2.5.3-pre5, the patch achieves a 2.5% improvement in
> 2-task lat_ctx context-switch performance.

(the 2.5% improvement is correct.)

	Ingo

