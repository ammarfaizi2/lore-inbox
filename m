Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSGUXVS>; Sun, 21 Jul 2002 19:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSGUXVS>; Sun, 21 Jul 2002 19:21:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52934 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315168AbSGUXVS>;
	Sun, 21 Jul 2002 19:21:18 -0400
Date: Mon, 22 Jul 2002 01:23:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
In-Reply-To: <20020721221815.E26376@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207220105470.1622-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


update: after some offline debugging and RMK fixing a number of (mostly
SMP) bugs, both the serial line discipline and serial kernel console
features are now fully functional under the new serial subsystem. x86 SMP
and UP works fine as well.

i also applied it to the irqlock tree, and only a single line had to be
changed [synchronize_irq()] and it worked flawlessly on SMP.

i've uploaded the patch (against sched + irqlock tree), it's at:

  http://redhat.com/~mingo/remove-irqlock-patches/newserial-2.5.27-A0.bz2

I'd vote for Russell's stuff to be considered for inclusion ...

	Ingo




