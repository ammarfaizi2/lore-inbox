Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315468AbSFEPho>; Wed, 5 Jun 2002 11:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315469AbSFEPhn>; Wed, 5 Jun 2002 11:37:43 -0400
Received: from waste.org ([209.173.204.2]:17041 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S315468AbSFEPhm>;
	Wed, 5 Jun 2002 11:37:42 -0400
Date: Wed, 5 Jun 2002 10:37:41 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <E17Fbj3-0001YS-00@starship>
Message-ID: <Pine.LNX.4.44.0206050957250.2614-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Daniel Phillips wrote:

> This is precisely the sort of design limitation we're tearing down with
> these hybrid realtime/non-realtime systems.  Your mistake is assuming
> that every form of communication between the two has to be tightly
> coupled.

No, the mistake is assuming that loosely coupling UNIX to RT lets you
leverage much of anything from UNIX. The whole attraction of a hybrid
system is the idea of building an app in a "normal" operating system on
top of a realtime layer because it's much easier to code for normal
operating system than realtime. Normal operating systems lets you have
real stacks and memory management and paging and fast filesystems and TCP
and load >= 1.

And your MP3-player example is a great one of where you don't get much out
of it. You have to rewrite _everything_ to run in the RT space. Yes,
doable, but how is it better from a developer perspective than the
duct-taped RIO approach? Tape it inside the box with USB (there's your
shared filesystem) if that makes you happier.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

