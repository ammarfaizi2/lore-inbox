Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbQJ3J6U>; Mon, 30 Oct 2000 04:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129179AbQJ3J6K>; Mon, 30 Oct 2000 04:58:10 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:25606 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129078AbQJ3J5z>; Mon, 30 Oct 2000 04:57:55 -0500
Date: Mon, 30 Oct 2000 02:54:24 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030025424.A20271@vger.timpanogas.org>
In-Reply-To: <20001030023814.B20102@vger.timpanogas.org> <Pine.LNX.4.21.0010301156380.3186-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010301156380.3186-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 12:01:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 12:01:08PM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > > And please check your numbers, 857 million
> > > context switches per second means that on a 1 GHZ CPU you do one context
> > > switch per 1.16 clock cycles. Wow!
> > 
> > Excuse me, 857,000,000 instructions executed and 460,000,000 context switches
> > a second -- on a PII system at 350 Mhz. [...]
> 
> so it does 1.3 context switches per clock cycle? Wow! And i can type
> 100000000000000000000 characters a second, just measured it. Really!

Go download it and try it, then come back with that smirk wiped off your face.
I'll enjoy it.....

:-)

> 
> > Your Tux web server will also run on it, at significantly increased
> > performance.
> 
> as i told you in the previous mails, TUX does not depend on schedule()
> performance. schedule() cost does not even show up in the top 20 entries
> of the profiler.


And as I told, you, your code has nothing to do with it, it's the fact it 
goes on at all.  Ingo, go get a copy of NetWare 3.12 (I'll even send you
one -- I've got extra licensed copies), install it, put a load of 5000
connections on it, with 4 adapters.  Dual boot Linux on it, and attempt 
the same with SAMBA or MARS-NWE, and watch it oink.  

Go do it.  What's your address to I can ship you the CD's for 3.12.  Then come
back and tell me how TUX is going to solve the File and Print performance
issues in Linux.

:-)

Jeff

 
> 
> 	Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
