Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266062AbRF1R5F>; Thu, 28 Jun 2001 13:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266070AbRF1R44>; Thu, 28 Jun 2001 13:56:56 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:24082 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266062AbRF1R4m> convert rfc822-to-8bit; Thu, 28 Jun 2001 13:56:42 -0400
Date: Thu, 28 Jun 2001 10:55:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <chuckw@altaserv.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vipin Malik <vipin.malik@daniel.com>,
        Aaron Lehmann <aaronl@vitelus.com>,
        David Woodhouse <dwmw2@infradead.org>, <jffs-dev@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <Pine.LNX.4.33.0106281028170.10308-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0106281035250.15199-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id KAA01519
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Jun 2001 chuckw@altaserv.net wrote:
>
> Taking that one step further, isn't it a developer's right to "toot their
> own horn" in their code?

You can do whatever you want in your own code.

But if it makes the code behave badly, others have the right to change it.
That's what the GPL is all about (you have the right to change it even if
it _doesn't_ "behave badly", of course ;)

You mustn't remove copyright messages, but you can certainly move them (as
long as they are prominently displayed in the source - see §1 in the GPL
about "conspicuously and appropriately publish").  But that certainly
doesn't preclude moving it into a comment, for example. So that it doesn't
end up disturbing users who have nothing to do with it.

(Note: the "conspicuously and appropriately publish" thing is obviously a
matter of taste, especially the "appropriately". So it would easily be
considered non-appropriate to move _one_ copyright holder into a comment,
while printing out the names of the others. But if you make it a policy to
do it across the board, that's clearly "appripriately publishing").

The GPL requires that you "keep intact all the notices that refer to this
License and to the absence of any warranty" in the verbatim copy of the
programs source code. It doesn't require that you print it out on use (it
has that silly "interactive program that is already verbose about the
copyright" thing in 2c, but happily that doesn't cover the kernel anyway).

There's another side to "drumming your own drum": it is often seen as
actively offensive to some people who don't want to do the same thing.

Copyright messages often disturb developers even when they are only in the
code. Which is why they should be at the top, and ONLY at the top. That's
where they are most visible for people who search for them (remember: the
copyright message is not primarily for tooting your own horn, it's
primarily there to inform people who _wonder_ about whom to contact about
the copyright status of the file).

And that's also where they aren't in the way for development, and for
making changes (what should you do if you change some piece of code, and
the comment above it has somebody elses copyright in it - while you've now
change the code to make the comment meaningless?)

And note that this is not actually a hypothetical example. There have been
real-world cases where major developers have complained about other
developers copyright notices being disturbingly "in the way".

So there's "drumming your own drum", but there's also "being a loudmouth".

		Linus

