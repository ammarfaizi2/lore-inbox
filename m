Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318799AbSG0SUA>; Sat, 27 Jul 2002 14:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318802AbSG0ST7>; Sat, 27 Jul 2002 14:19:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19849 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318799AbSG0ST7>;
	Sat, 27 Jul 2002 14:19:59 -0400
Date: Sat, 27 Jul 2002 20:21:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, <mingo@redhat.com>
Subject: Re: Serial Oopsen caused by global IRQ chanes
In-Reply-To: <20020727191906.D32766@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207272020490.19150-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 Jul 2002, Russell King wrote:

> > Two people have now reported to me a couple of oopsen which appear to be
> > caused by a change in 2.5.29 to synchronize_irq(), which I believe has
> > made synchronize_irq() useless.
> 
> Sorry, not useless.  Just free_irq extremely buggy.

i found the bug, will send a patch soon.

	Ingo

