Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273203AbRI3JEL>; Sun, 30 Sep 2001 05:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273147AbRI3JEB>; Sun, 30 Sep 2001 05:04:01 -0400
Received: from chiara.elte.hu ([157.181.150.200]:46353 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S273203AbRI3JDq>;
	Sun, 30 Sep 2001 05:03:46 -0400
Date: Sun, 30 Sep 2001 11:01:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <bcrl@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <200109281923.XAA05208@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0109301058110.3127-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001 kuznet@ms2.inr.ac.ru wrote:

> Argh... I see, what you mean. It is not priority, it is bug introduced
> in 2.4.7. (By you? :-)) [...]

not by me. the 2.4.6 softirq changes/cleanups (softirq_pending cleanups,
restart softirqs in various places, etc.) are the ones from me (the loop
until done stuff). 2.4.7 contains the ksoftirqd related changes/cleanups.

	Ingo

