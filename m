Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTJFWsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 18:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTJFWsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 18:48:21 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:52754
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261786AbTJFWsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 18:48:19 -0400
Date: Mon, 6 Oct 2003 15:46:03 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pascal Schmidt <der.eremit@email.de>
cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <E1A6aWv-0000rJ-00@neptune.local>
Message-ID: <Pine.LNX.4.10.10310061532330.31134-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Oct 2003, Pascal Schmidt wrote:

> On Mon, 06 Oct 2003 20:50:12 +0200, you wrote in linux.kernel:
> 
> > That has no bearing on the legalities.  A version of the kernel can't
> > force the GPL on a driver that works with that version of the kernel
> > because you can pull that driver out and drop in another.
> 
> Okay, I can see the boundary. We still have the problem that drivers
> writers have to be very careful to not copy kernel code by accident
> because the kernel changes often, which creates a temptation to look
> closely at in-tree drivers to see how they do things. And if a
> drivers writer then produces code that is essentialy the same as is
> found in the kernel, only with changed indentation and variable names,
> I think we both a agree that such a driver would be a derived work.

You can look all you want, just can not touch.

Simiar to the red light district in Holland, it costs alot to do more
than look throught the glass.

> Another problem is the fact that Linux kernel headers can contain code
> in the form of macros. If a driver uses such a header, it links kernel
> code with itself which can easily make it a derived work.

No it can not, by only using the headers as the functional API for that
snapshot verson of the kernel release, it is the standard means for
functionality.  If the macro is require for any driver and or one in the
kernel to function, and is listed in the headers, it is generally deemed
to part of the unportected API.

Again it is very simple declare, all modules which are not GPL and reject
loading, and we can watch the death of linux as nobody will use it.  Again
who cares, because it started out as fun for a Finn in 1991, and should
never be of use or value outside of academics.

All of the code monkeys here need to be equally exploited by all.  Some of
the best marketing pitchs to date for some of the big companies who claim
to be linux friends, their slogans translated:

Use our hardware with Linux, there are a lot of suckers out there with
talnet who will gladly help you with your support issues.  This reduces
our support costs because we cans send you to join the rest of the
monkeys, Pinocchio.

Harsh and reality suck, but I could not believe this is what is being
pitched at trade shows.

Later ...

Andre


