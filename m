Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289108AbSA3LRp>; Wed, 30 Jan 2002 06:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289110AbSA3LR0>; Wed, 30 Jan 2002 06:17:26 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:11408 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289108AbSA3LRV>;
	Wed, 30 Jan 2002 06:17:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 12:21:29 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201301123350.7341-100000@serv>
In-Reply-To: <Pine.LNX.4.33.0201301123350.7341-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Vsny-0000Dj-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 11:39 am, Roman Zippel wrote:
> Hi,
> 
> On Wed, 30 Jan 2002, Daniel Phillips wrote:
> 
> > Yes, we should cc our patches to a patchbot:
> >
> >   patches-2.5@kernel.org -> goes to linus
> >   patches-2.4@kernel.org -> goes to marcello
> >   patches-usb@kernel.org -> goes to gregkh, regardless of 2.4/2.5
> >   etc.
> 
> I'd rather make the patchbot more intelligent, that means it analyzes the
> patch and produces a list of touched files. People can now register to get
> notified about patches, which changes areas they are interested in.

But they can already do that, by subscribing to the respective mailing list 
(obviously, the bot posts to the list as well as forwarding to the 
maintainer) and running the mails through a filter of their choice.

> In the simplest configuration nothing would change for Linus, but patches
> wouldn't get lost and people could be notified if their patch was applied
> or if it doesn't apply anymore.

OK, it would be nice, but you wouldn't want to pile on so many features that 
this never gets implemented would you?  The minimal thing that forwards and 
posts patches is what we need now.  Like any other software it can be 
improved over time.

> Other people have a place to search for patches and they can check whether 
> something was already fixed.

Automating the applied/dropped status is clearly the next problem to tackle, 
but that's harder, it involves behavioral changes on the maintainers side.  
(Pragmatically, providing a web interface so somebody whose job it is to do 
that, can efficiently post 'applied' messages to the list would get the job 
done without making anyone learn new tools or change the way they work.)

By the way, who is going to code this?  Or are we determined to make 
ourselves look like wankers once again, by putting considerably more time 
into the lkml flamewar than goes into producing working code?

(Hint: I am not going to code it, nor should I since I should be working in 
the kernel.)

-- 
Daniel
