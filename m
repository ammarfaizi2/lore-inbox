Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293386AbSCOWAx>; Fri, 15 Mar 2002 17:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293379AbSCOWAd>; Fri, 15 Mar 2002 17:00:33 -0500
Received: from users.ccur.com ([208.248.32.211]:5545 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S293373AbSCOWAb>;
	Fri, 15 Mar 2002 17:00:31 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200203152159.VAA27831@rudolph.ccur.com>
Subject: Re: [PATCH] 2.4.18 scheduler bugs
To: mingo@elte.hu
Date: Fri, 15 Mar 2002 16:59:31 -0500 (EST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), joe.korty@ccur.com (Joe Korty),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <Pine.LNX.4.44.0203152138550.22550-100000@elte.hu> from "Ingo Molnar" at Mar 15, 2002 09:42:33 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [...] But on the Athlon the IPI isnt going down a little side channel
> > between cpus.
> 
> but even in the Athlon case an IPI is still an IRQ entry, which will add
> at least 200 cycles or more to the idle wakeup latency.

It is an idle cpu that is spending those 200 cycles.

Joe
