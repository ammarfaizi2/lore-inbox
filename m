Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbRDPWY6>; Mon, 16 Apr 2001 18:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRDPWYs>; Mon, 16 Apr 2001 18:24:48 -0400
Received: from relay1.pair.com ([209.68.1.20]:63239 "HELO relay1.pair.com")
	by vger.kernel.org with SMTP id <S131643AbRDPWYl>;
	Mon, 16 Apr 2001 18:24:41 -0400
X-pair-Authenticated: 203.164.4.223
From: "Manfred Bartz" <md-linux-kernel@logi.cc>
Message-ID: <20010416222411.5879.qmail@logi.cc>
To: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan> <01041708461209.00352@workshop> <20010416020732.30431.qmail@logi.cc> <20010416104310.A29075@flint.arm.linux.org.uk>
X-Subversion: anarchy bomb crypto drug explosive fission gun nuclear sex terror
In-Reply-To: Russell King's message of "Mon, 16 Apr 2001 10:43:10 +0100"
Organization: rows-n-columns
Date: 17 Apr 2001 08:24:11 +1000
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Mon, Apr 16, 2001 at 12:07:31PM +1000, Manfred Bartz wrote:
> > There is another issue with logging in general:
> > 
> >                 *COUNTERS MUST NOT BE RESETABLE!!!*
> 
> Umm, no.  Counters can be resetable - you just specify that accounting
> programs should not reset them, ever.
> 
> The ability to reset counters is extremely useful if you're a human
> looking at the output of iptables -L -v.  (I thus far know of no one
> who can memorise the counter values for around 40 rules).

You just illustrated my point.  While there is a reset capability
people will use it and accounting/logging programs will get wrong
data.  Resetable counters might be a minor convenience when debugging
but the price is unreliable programs and the loss of the ability of
several programs to use the same counters.

Also, do you always reset the date and time everytime you make time 
measurements?

-- 
Manfred Bartz
