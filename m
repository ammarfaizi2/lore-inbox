Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317423AbSGVODS>; Mon, 22 Jul 2002 10:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSGVODR>; Mon, 22 Jul 2002 10:03:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36065 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317423AbSGVODQ>;
	Mon, 22 Jul 2002 10:03:16 -0400
Date: Mon, 22 Jul 2002 16:05:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: martin@dalecki.de
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <3D3C0F49.4070707@evision.ag>
Message-ID: <Pine.LNX.4.44.0207221602560.9963-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


well, if/when there's a concensus i'll do the type checking change in a
'second wave' patch, since it's a distinct issue not directly connected to
the naming cleanup.

there are some more IRQ subsystem cleanups for which i have patches: such
as the removal of the pt_regs parameter from the irq handler function,
it's unused in 99% of the drivers - and the remaining 1% can get at it via
other means.

	Ingo

