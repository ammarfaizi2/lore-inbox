Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131031AbQLPBwz>; Fri, 15 Dec 2000 20:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130650AbQLPBwp>; Fri, 15 Dec 2000 20:52:45 -0500
Received: from zeus.kernel.org ([209.10.41.242]:23560 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131031AbQLPBwi>;
	Fri, 15 Dec 2000 20:52:38 -0500
Date: Thu, 14 Dec 2000 17:11:47 -0700 (MST)
From: Dan Egli <dan@tools.c4usa.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <Pine.LNX.4.10.10012141543130.12695-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012141708160.13899-100000@tools.c4usa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000, Linus Torvalds wrote:

> Yes. 
> 
> And I realize that somebody inside RedHat really wanted to use a snapshot
> in order to get some C++ code to compile right.
> 
> But it at the same time threw C stability out the window, by using a
> not-very-widely-tested snapshot for a major new release. 
> 
> Are you seriously saying that you think it was a good trade-off? Or are
> you just ashamed of admitting that RH did something stupid?
> 
Pardon the poking in here, but I must say I agree here. RH did a VERY dumb
thing. 

> I have a report from a Sony VAIO user that couldn't compile the CVS X at
> all on his picturebook (and you need to compile the CVS tree in order to
> get required fixes for the ATI Rage Mobility in that machine). I don't
> know the details, but they were apparently due to RH 7 issues. 

It's not in the X tree or anything, but here's a personal example.
Machine: Dual P3 550
HDD: Dual Ultra2Wide Seagate 18GB Hdd
OS: RedHat 7
Compile Target: Linux Kernel 2.2.17
Result with gcc 2.96: Failure (syntax errors in the i386 branch of the
arch tree)
Result with compat-egcs-62: Success on the first try.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
