Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280364AbRJaTkt>; Wed, 31 Oct 2001 14:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280324AbRJaTkj>; Wed, 31 Oct 2001 14:40:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62482 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280416AbRJaTkf>; Wed, 31 Oct 2001 14:40:35 -0500
Date: Wed, 31 Oct 2001 11:38:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Michael Peddemors <michael@wizard.ca>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
In-Reply-To: <1004556431.11209.51.camel@mistress>
Message-ID: <Pine.LNX.4.33.0110311126500.32727-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 31 Oct 2001, Michael Peddemors wrote:
>
> Lets' let this testing cycle go a little longer before making any
> changes.. Let developers catch up..

My not-so-cunning plan is actually to try to figure out the big problems
now, then release a reasonable 2.4.14, and then just stop for a while,
refusing to take new features.

Then, 2.4.15 would be the point where I start 2.5.x, and where Alan gets
to do whatever he wants to do with 2.4.x. Including, of course, just
reverting all my and Andrea's VM changes ;)

I'm personally convinced that my tree does the right thing VM-wise, but
Alan _will_ be the maintainer, and I'm not going to butt in on his
decisions. The last thing I want to be is a micromanaging pointy-haired
boss.

(2.5.x will obviously use the new VM regardless, and I actually believe
that the new VM simply is better. I think that Alan will see the light
eventually, but at the same time I clearly admit that Alan was right on a
stability front for the last month or two ;)

> My own kernel patches I had to stop because I couldn't keep up ....  Can
> we go a full month with you just hitting us over the head with a bat
> yelling 'test, dammit, test', until this is tested fully before
> releasing another production release?

I think we're really close.

[ I'd actually like to thank Gary Sandine from laclinux.com who made the
  "Ultimate Linux Box" for an article by Eric Raymond for Linux Journal.
  They sent me one too, and the 2GB box made it easier to test some real
  highmem loads. This has given me additional load environments to test,
  and made me able to see some of the problems people reported.. ]

But I do want to make a real 2.4.14, not just another "final" pre-kernel,
and let that be the base for a reasonably orderly switch-over at 2.4.15
(ie I'd still release 2.4.15, everything from then on is Alan).

		Linus

