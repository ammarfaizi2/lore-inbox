Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274029AbRIXQxs>; Mon, 24 Sep 2001 12:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274034AbRIXQxi>; Mon, 24 Sep 2001 12:53:38 -0400
Received: from chiara.elte.hu ([157.181.150.200]:43272 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S274031AbRIXQx1>;
	Mon, 24 Sep 2001 12:53:27 -0400
Date: Mon, 24 Sep 2001 18:51:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: <arjan@fenrus.demon.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10aa1 (00_vm-tweaks-1)
In-Reply-To: <20010923234955.F1782@athlon.random>
Message-ID: <Pine.LNX.4.33.0109241849350.6512-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Sep 2001, Andrea Arcangeli wrote:

> we're having troubles with the ioapic compiled in in UP on some
> machine, on 2.4.10pre I assume. Waiting bios updates is more
> problematic then enabling on demand rather than disabling on demand,

the right policy is to disable-on-demand, especially if the breakage is
well established and is also uncommon. It's the faulty case that should do
the extra work. Good systems should not be punished needlessly.

	Ingo

