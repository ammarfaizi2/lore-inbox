Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbRF1SAZ>; Thu, 28 Jun 2001 14:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266071AbRF1SAF>; Thu, 28 Jun 2001 14:00:05 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:39954 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266069AbRF1R74>; Thu, 28 Jun 2001 13:59:56 -0400
Date: Thu, 28 Jun 2001 10:58:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <chuckw@altaserv.net>
cc: Aaron Lehmann <aaronl@vitelus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Vipin Malik <vipin.malik@daniel.com>,
        David Woodhouse <dwmw2@infradead.org>, <jffs-dev@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <Pine.LNX.4.33.0106281040000.10308-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0106281057170.15199-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Jun 2001 chuckw@altaserv.net wrote:
>
> > > Taking that one step further, isn't it a developer's right to "toot their
> > > own horn" in their code?
> >
> > Right. In the code. Not in the Linux boot diagnostic information.
>
> Which is why I proposed earlier that we make it easy to shut them off.
> Alan piped in with the "quiet" boot option.

If they are shut off, then where's the drumming? Because if people start
making copyright printk's normal, I will make "quiet" the default.

Also, in printk's, you waste run-time memory, and you bloat up the need
for the log size. Both of which are _technical_ reasons not to do it.

Small is beuatiful.

		Linus

