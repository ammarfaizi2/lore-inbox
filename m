Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbUBPNZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUBPNZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:25:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38611 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265505AbUBPNZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:25:28 -0500
Date: Mon, 16 Feb 2004 12:39:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       matthew@wil.cx, rth@twiddle.net
Subject: Re: When should we use likely() / unlikely() / get_unaligned() ?
Message-ID: <20040216113946.GB470@openzaurus.ucw.cz>
References: <1076065578.16147.72.camel@hades.cambridge.redhat.com> <20040208214335.58f351d4.rusty@rustcorp.com.au> <1076238833.12587.229.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076238833.12587.229.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A probability argument for get_unaligned() allows those architectures to
> _unconditionally_ emit inline unaligned load/store code, while allowing
> other, saner, architectures to start doing so only when the probability
> means it makes sense.
> 
> The alternative would be a get_unlikely_unaligned() which does the same

I think that this alternative is way better than introducing
probabilities.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

