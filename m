Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132003AbRCYOs4>; Sun, 25 Mar 2001 09:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132006AbRCYOsq>; Sun, 25 Mar 2001 09:48:46 -0500
Received: from [195.63.194.11] ([195.63.194.11]:55046 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132003AbRCYOsh>; Sun, 25 Mar 2001 09:48:37 -0500
Message-ID: <3ABE023A.10D2FE24@evision-ventures.com>
Date: Sun, 25 Mar 2001 16:35:38 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, hpa@transmeta.com,
        tytso@MIT.EDU, linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
In-Reply-To: <Pine.LNX.4.31.0103241920580.6710-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 24 Mar 2001 Andries.Brouwer@cwi.nl wrote:
> >
> > We need a size, and I am strongly in favor of sizeof(dev_t) = 8;
> > this is already true in glibc.
> 
> The fact that glibc is a quivering mass of bloat, and total and utter crap
> makes you suggest that the Linux kernel should try to be as similar as
> possible?
> 
> Not a very strong argument.
> 
> There is no way in HELL I will ever accept a 64-bit dev_t.
> 
> I _will_ accept a 32-bit dev_t, with 12 bits for major numbers, and 20
> bits for minor numbers.
> 
> If people cannot fit their data in that size, they have some serious
> problems. And for people who think that you should have meaningful minor
> numbers where the bit patterns get split up some way, I can only say "get
> a frigging clue". That's what you have filesystem namespaces for. Don't
> try to make binary name-spaces.
> 
> And I don't care one _whit_ about the fact that Ulrich Drepper thinks that
> it's a good idea to make things too large.

Amen. It's entierly sufficent to take a size similiar to the one
on systems which don't have the problems linux has in this area.
Our daily motto should be: "Maybe we don't know a shit about
OS design - but we known very well up to the ground how Solaris works."

Please forgive me If I stressed your sense of humour a bit too much :-)
