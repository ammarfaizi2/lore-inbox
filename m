Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282483AbRLAXVI>; Sat, 1 Dec 2001 18:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282481AbRLAXUs>; Sat, 1 Dec 2001 18:20:48 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:41228 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282479AbRLAXUo>; Sat, 1 Dec 2001 18:20:44 -0500
Date: Sat, 1 Dec 2001 15:31:20 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <E16A75O-0006hY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112011517410.1696-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001, Alan Cox wrote:

> > > Wasn't it you that were saying that Linux will never scale with more than
> > > 2 CPUs ?
> >
> > No, that wasn't me.  I said it shouldn't scale beyond 4 cpus.  I'd be pretty
> > lame if I said it couldn't scale with more than 2.  Should != could.
>
> Question: What happens when people stick 8 threads of execution on a die with
> a single L2 cache ?

Or for example the new HP PARISC design ( Mako ) with two on-die cores,
3-4 Mb L1 I-Cache per core, 3-4 Mb L1 D-Cache per core and up to 32 Mb
external L2 ( with on-die tagging ).
Anyway it's still better 8 on-die threads of execution sharing an L2
instead of 8 CPU with 1 thread of execution shring through the external
bus.




- Davide



