Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbSKRXsj>; Mon, 18 Nov 2002 18:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbSKRXsj>; Mon, 18 Nov 2002 18:48:39 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:42121 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S267049AbSKRXsh>; Mon, 18 Nov 2002 18:48:37 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 15:56:03 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Ulrich Drepper <drepper@redhat.com>, Mark Mielke <mark@mark.mielke.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021118225625.GB3939@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211181553430.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Jamie Lokier wrote:

> 1. Fwiw, I would really like to see epoll extended beyond fds, to a more
> general edge-triggered event collector - signals, timers, aios.  I've
> written about this before as you know (but been too busy lately to
> pursue the idea).  I'm not going to say any more about this until I
> have time to code something...

Anything that "exposes" a file* interface that support f_op->poll() is
usable with epoll. File rocks !! :)



> 2. I don't like the "int64_t" proposal because there is no
>    language guarantee that 64 bits is enough to hold a pointer - and
>    of course, a pointer is what many applications will store in it.

I know, but we should be covered for another 8-10 years with 64 bits :)



- Davide


