Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbRF1RNz>; Thu, 28 Jun 2001 13:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266039AbRF1RNp>; Thu, 28 Jun 2001 13:13:45 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:48143 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266038AbRF1RNh>; Thu, 28 Jun 2001 13:13:37 -0400
Date: Thu, 28 Jun 2001 10:12:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <chuckw@altaserv.net>, Vipin Malik <vipin.malik@daniel.com>,
        Aaron Lehmann <aaronl@vitelus.com>,
        David Woodhouse <dwmw2@infradead.org>, <jffs-dev@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <E15Fed3-0007Co-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106281006100.15199-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Jun 2001, Alan Cox wrote:
>
> > Perhaps even a boot flag of some sort to de-activate the printing of the
> > /proc/credits during the kernel boot sequence. Or would the community
> > rather an opt-in scenario...
>
> Leave the copyright messages alone is all I can say. And as to your flag,
> well we've got one. Try the 'quiet' boot option

I absolutely _abhor_ the fact that most distributions seem to set the
default logging level to be "emergency only". That's wrong. The default
logging level should be "print out everything but debugging", and we
should make sure that normal code _never_ spits stuff out that happens
during regular use.

As it is now, when something bad actually _does_ happen, many
distributions will simply not print anything at all, because user
processes are dead by then.

And why did the distributions do this? Because we tend to be too damn
verbose for our own good.

As to the credit argument: put your copyright at the top of the source
file. The people who care and matter will see it. And do NOT hide the
copyright with reams of changelog information. Put that in a separate file
if you must.

		Linus

