Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293552AbSCKWqZ>; Mon, 11 Mar 2002 17:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293547AbSCKWqR>; Mon, 11 Mar 2002 17:46:17 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:61191 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S293543AbSCKWp5>; Mon, 11 Mar 2002 17:45:57 -0500
Date: Mon, 11 Mar 2002 23:45:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>, Martin Dalecki <martin@dalecki.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020311234553.A3490@ucw.cz>
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Mar 11, 2002 at 02:39:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 02:39:14PM -0800, Linus Torvalds wrote:

> On Mon, 11 Mar 2002, Alan Cox wrote:
> > 
> > Its quite different to other goings on
> 
> Alan, did you actually look at the diffs that Martin sent out, or are you 
> just reacting to the description?
> 
> I think you read more into the description than was actually in the patch 
> itself.
> 
> Rule #1: always read the patch.
> 
> Right now, that patch definitely needs to learn to use "yield()" instead
> of "schedule()" etc details, but I really don't understand why all the 
> brouhaha over Martins patches.
> 
> Am I really the only one who actually reads the actual _changes_ instead
> of arguing over personal issues?
> 
> Now, I've long had this theory that IDE coding is bad for your mental
> health (you won't ever see _me_ going close to the dang thing - I'll use
> it, but I won't start writing code for it), but that theory used to be a
> _joke_, for chrissake! Don't make it appear a truism.

Are you, by any chance, confusing my AMD IDE changes with Pavel Machek's
first attempt at IDE wake/suspend code?

Gee, I think we all need some calming down and sleep ...

-- 
Vojtech Pavlik
SuSE Labs
