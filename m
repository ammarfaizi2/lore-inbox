Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSJXOSh>; Thu, 24 Oct 2002 10:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265447AbSJXOSg>; Thu, 24 Oct 2002 10:18:36 -0400
Received: from max.fiasco.org.il ([192.117.122.39]:32006 "HELO
	latenight.fiasco.org.il") by vger.kernel.org with SMTP
	id <S265446AbSJXOSf>; Thu, 24 Oct 2002 10:18:35 -0400
Subject: Re: One for the Security Guru's
From: Gilad Ben-ossef <gilad@benyossef.com>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ap8f36$8ge$1@forge.intermeta.de>
References: <Pine.LNX.3.95.1021023105535.13301A-100000@chaos.analogic.com>
	<Pine.LNX.4.44.0210231346500.26808-100000@innerfire.net> 
	<ap8f36$8ge$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Oct 2002 16:23:35 +0200
Message-Id: <1035469419.7166.212.camel@klendathu.telaviv.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 11:38, Henning P. Schmiedehausen wrote:

> So you should've bought a more expensive firewall that offers protocol
> based forwarding instead of being a simple packet filter.
> 
> packet filter != firewall. That's the main lie behind most of the
> "Linux based" firewalls.
> 
> Get the real thing. Checkpoint. PIX. But that's a little
> more expensive than "xxx firewall based on Linux".

AFAIK Linux has "protocol base forwarding" (more commonly known as
"state-full inspection") for *some* protocols. 

Also, although Firewall-1 and PIX are very good products (and provide
income to some of my best friends :-), the implications that they are
somehow magically much better then the freely available ones is somewhat
misleading IMHO. 

They certainly offer more *features*, the question is whether these
additional features indeed translate into better security. IMHO for most
cases the answer is negative. Again, this is not because they are not
good (or even better), but rather that they are better answer to the
wrong question - the TCP and HTTP stream is perfectly fine and legal and
the buffer overflow "hides" in the data payload but firewalls can't stop
that (unless it's a relatively old attack) and that is, again IMHO,
where the problems seems to be today.

> 
> Actually, there _are_ security consultants, that know what they're
> talking about. Unfortunately they're drowned out most of the time by
> the drone of so called "self-certified Linux experts" which believe,
> everything can be handled by using the only tool they know.

The important question is *always*: "what is the threat?" For a lot of
the practical common situations a Linux IPTables firewall will be as
effective as the top notch Checkpoint/CISCO solution because FW-1 and
PIX do offer a better parsing and response code (for example) but in the
end of the day it's upgrading your OpenSSL libraries on time and such
that really counts.

It's not about who is better - it's about who is *enough* to counter the
threat enough to get you to a point where that specific issue isn't the
'weakest link' anymore. I think Linux does that very very well in many
situations.

> 
> >Never trust Security Consultants.
> 
> BS. Invest money in real consultants that know their trade. They
> simply might not be the cheapest and they might tell you solutions
> that hurt (e.g. training your staff) but of course there are lots of
> people that know what they're talking about.

To this I all heartily agree. Get good people (and be prepared to *pay*
for good people) and then *listen* to them. Sadly, I believe that the
latter seems to be less common then the former... :-(

Gilad


