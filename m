Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293544AbSCKWkp>; Mon, 11 Mar 2002 17:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293546AbSCKWkg>; Mon, 11 Mar 2002 17:40:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49672 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293543AbSCKWkR>; Mon, 11 Mar 2002 17:40:17 -0500
Date: Mon, 11 Mar 2002 14:39:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>, Martin Dalecki <martin@dalecki.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Mar 2002, Alan Cox wrote:
> 
> Its quite different to other goings on

Alan, did you actually look at the diffs that Martin sent out, or are you 
just reacting to the description?

I think you read more into the description than was actually in the patch 
itself.

Rule #1: always read the patch.

Right now, that patch definitely needs to learn to use "yield()" instead
of "schedule()" etc details, but I really don't understand why all the 
brouhaha over Martins patches.

Am I really the only one who actually reads the actual _changes_ instead
of arguing over personal issues?

Now, I've long had this theory that IDE coding is bad for your mental
health (you won't ever see _me_ going close to the dang thing - I'll use
it, but I won't start writing code for it), but that theory used to be a
_joke_, for chrissake! Don't make it appear a truism.

			Linus

