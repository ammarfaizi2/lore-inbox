Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQJaUEV>; Tue, 31 Oct 2000 15:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129074AbQJaUEL>; Tue, 31 Oct 2000 15:04:11 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129026AbQJaUD4>;
	Tue, 31 Oct 2000 15:03:56 -0500
Message-ID: <20001031195012.A138@bug.ucw.cz>
Date: Tue, 31 Oct 2000 19:50:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030022024.B20023@vger.timpanogas.org> <Pine.LNX.4.21.0010301142040.3186-100000@elte.hu> <20001030023814.B20102@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001030023814.B20102@vger.timpanogas.org>; from Jeff V. Merkey on Mon, Oct 30, 2000 at 02:38:14AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This is putrid. NetWare does 353,00,000/second on a Xenon, pumping out
> > > gobs of packets in between them. MANOS does 857,000,000/second. This
> > > is terrible. No wonder it's so f_cking slow!!!
> 
> And please check your numbers, 857 million
> > context switches per second means that on a 1 GHZ CPU you do one context
> > switch per 1.16 clock cycles. Wow!
> 
> Excuse me, 857,000,000 instructions executed and 460,000,000 context
> switches
> a second -- on a PII system at 350 Mhz.  It's due to AGI
> optimization.  

That's more than one context switch per clock. I do not think
so. Really go and check those numbers.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
