Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbQJ3Jvu>; Mon, 30 Oct 2000 04:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129110AbQJ3Jva>; Mon, 30 Oct 2000 04:51:30 -0500
Received: from chiara.elte.hu ([157.181.150.200]:48902 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129102AbQJ3JvV>;
	Mon, 30 Oct 2000 04:51:21 -0500
Date: Mon, 30 Oct 2000 12:01:08 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030023814.B20102@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010301156380.3186-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> > And please check your numbers, 857 million
> > context switches per second means that on a 1 GHZ CPU you do one context
> > switch per 1.16 clock cycles. Wow!
> 
> Excuse me, 857,000,000 instructions executed and 460,000,000 context switches
> a second -- on a PII system at 350 Mhz. [...]

so it does 1.3 context switches per clock cycle? Wow! And i can type
100000000000000000000 characters a second, just measured it. Really!

> Your Tux web server will also run on it, at significantly increased
> performance.

as i told you in the previous mails, TUX does not depend on schedule()
performance. schedule() cost does not even show up in the top 20 entries
of the profiler.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
