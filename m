Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291043AbSAaMe3>; Thu, 31 Jan 2002 07:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291044AbSAaMeU>; Thu, 31 Jan 2002 07:34:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47076 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291043AbSAaMeL>;
	Thu, 31 Jan 2002 07:34:11 -0500
Date: Thu, 31 Jan 2002 15:31:17 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: David Weinehall <tao@acc.umu.se>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020131132830.W1735@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.33.0201311528550.9572-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jan 2002, David Weinehall wrote:

> On Thu, Jan 31, 2002 at 03:17:52PM +0100, Ingo Molnar wrote:
>
> > 'old' architectures do not hinder development - they are separate, and
> > they have to update their stuff. (and i think the m68k port is used by
> > many other people and not CS archeologists.) Old drivers are not a true
> > problem either - if they dont compile that's the problem of the
> > maintainer. Occasionally old drivers get zapped (mainly when there is a
> > new replacement driver).
>
> To testify that even really old hardware is used, I recently received
> a patch for 2.0.xx to add autodetection for wd1002s-wx2 in the
> xd.c-driver. Not particularly recent hardware, but the person who sent
> the patch uses it. Why deny him usage of his hardware when it doesn't
> intrude upon the rest of the codebase?

exactly. Cruft hanging around does hurt in the 'generic' kernel. There is
'leaf' code where it hurts much less. Sure, we'd like to have clean code
everywhere, and a driver with a clean and recent codebase will get more
attention from the architecture point of view, but to the user, an
outdated but working driver is better than no driver at all.

	Ingo

