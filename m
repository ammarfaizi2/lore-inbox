Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129083AbQJ3Jl7>; Mon, 30 Oct 2000 04:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQJ3Jlt>; Mon, 30 Oct 2000 04:41:49 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:19974 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129083AbQJ3Jlk>; Mon, 30 Oct 2000 04:41:40 -0500
Date: Mon, 30 Oct 2000 02:38:14 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030023814.B20102@vger.timpanogas.org>
In-Reply-To: <20001030022024.B20023@vger.timpanogas.org> <Pine.LNX.4.21.0010301142040.3186-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010301142040.3186-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 11:44:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 11:44:26AM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > This is putrid. NetWare does 353,00,000/second on a Xenon, pumping out
> > gobs of packets in between them. MANOS does 857,000,000/second. This
> > is terrible. No wonder it's so f_cking slow!!!

And please check your numbers, 857 million
> context switches per second means that on a 1 GHZ CPU you do one context
> switch per 1.16 clock cycles. Wow!

Excuse me, 857,000,000 instructions executed and 460,000,000 context switches
a second -- on a PII system at 350 Mhz.  It's due to AGI optimization.  
Download MANOS and verify for yourself, it has a built in EMON in monitor.
After I complete the port, not even NetWare will be able to touch it.

Your Tux web server will also run on it, at significantly increased 
performance.  

Jeff

> 
> 	Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
