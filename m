Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130810AbQLRIwq>; Mon, 18 Dec 2000 03:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131034AbQLRIwh>; Mon, 18 Dec 2000 03:52:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50185 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130810AbQLRIwe>; Mon, 18 Dec 2000 03:52:34 -0500
Date: Mon, 18 Dec 2000 09:21:58 +0100
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/random: really secure?
Message-ID: <20001218092158.A7328@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20001217225057.A8897@atrey.karlin.mff.cuni.cz> <NCBBLIEPOCNJOAEKBEAKKEFEMIAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKKEFEMIAA.davids@webmaster.com>; from davids@webmaster.com on Sun, Dec 17, 2000 at 04:18:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	There are hidden sources of entropy. One is clock skew between the keyboard
> processor's clock, the keyboard controller's clock, and the CPU clock
> generator's PLL. Another is data motion between the CPU cache and main

In the RFC 1750, they write it is not recommended to rely on computer clocks to
generate random. Isn't it this case?

> > depends solely on the network packets. These can be manipulated and their
> > leading edge precisely sniffed. I think here exists a severe risk of
> > compromise. Am I right?
> 
> 	Nope. There is no way to sniff their leading edge accurate to a billionth
> of a second. If you have a 1Ghz Pentium 3, that's the accuracy you'd need.

But it reduces the entropy. When I have a 486/66 and sniff packets accurately to
3MHz, only 4 bits remain. These bits need not to show a uniform distribution so
it could be even easier to guess them.

Clock
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
