Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291061AbSAaNKh>; Thu, 31 Jan 2002 08:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291062AbSAaNK1>; Thu, 31 Jan 2002 08:10:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2282 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291061AbSAaNKP>;
	Thu, 31 Jan 2002 08:10:15 -0500
Date: Thu, 31 Jan 2002 16:07:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: David Weinehall <tao@acc.umu.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <3C593EEC.3000907@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0201311604050.10258-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jan 2002, Martin Dalecki wrote:

> It's an incredibble bandwidth waste for 99.99% of people downolading
> 2.5.xx and it *is* making architectural changes in the kernel harder,
> becouse the modularisatoin of the kernel isn't nearly as perfect as
> you try to disguise it here. Please just have a look at the
> consequences of the kdev_t changes, which where necessary since
> already about 8 years. And then my these is somehow tautological if it
> doesn't apply now, it will apply in about 4 years. At some point in
> time there is the need to let some things go - the problem is more
> fundamental.

it's not mandatory for the developer to push every interface change into
every driver or every architecture. Sure, if some code has not been kept
in sync for a long time then it should be zapped, but the pure fact that
something is less often used should not make it a candidate for zapping.

	Ingo

