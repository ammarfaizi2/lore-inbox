Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130773AbQJaWCZ>; Tue, 31 Oct 2000 17:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130772AbQJaWCQ>; Tue, 31 Oct 2000 17:02:16 -0500
Received: from chiara.elte.hu ([157.181.150.200]:45063 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130769AbQJaWCF>;
	Tue, 31 Oct 2000 17:02:05 -0500
Date: Wed, 1 Nov 2000 00:12:01 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF3F0B.81A1EE13@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011010010380.16674-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Oct 2000, Jeff V. Merkey wrote:

> > > > Excuse me, 857,000,000 instructions executed and 460,000,000
> > > > context switches a second -- on a PII system at 350 Mhz. [...]
> > 
> > > That's more than one context switch per clock. I do not think so.
> > > Really go and check those numbers.
> > 
> > yep, you cannot have 460 million context switches on that system,
> > unless you have some Clintonesque definition for 'context switch' ;-)
> 
> The numbers don't lie. [...]

sure ;) I can do infinite context switches! You dont believe? See:

	#define schedule() do { } while (0)

[there is a small restriction, should only be used in single-task
systems.]

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
