Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283056AbRLQXWw>; Mon, 17 Dec 2001 18:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283052AbRLQXWn>; Mon, 17 Dec 2001 18:22:43 -0500
Received: from urtica.linuxnews.pl ([217.67.192.54]:27913 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S283054AbRLQXWa>; Mon, 17 Dec 2001 18:22:30 -0500
Date: Tue, 18 Dec 2001 00:22:22 +0100 (CET)
From: Pawel Kot <pkot@linuxnews.pl>
To: <jt@hpl.hp.com>
cc: Martin Diehl <lists@mdiehl.de>, Dag Brattli <dagb@cs.uit.no>,
        <linux-kernel@vger.kernel.org>, <linux-irda@pasta.cs.uit.no>
Subject: Re: [BUG()] IrDA in 2.4.16 + preempt
In-Reply-To: <20011217144549.B3647@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.33.0112180020010.662-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Jean Tourrilhes wrote:

> > On Fri, 14 Dec 2001, Pawel Kot wrote:
> >
> > > I found an annoying problem with irda on 2.4.16.
> > > When I remove irlan module I get sementation fault:
> > > root@blurp:~# rmmod irlan
> > > Dec 14 02:27:35 blurp kernel: kernel BUG at slab.c:1200!
> > > Dec 14 02:27:35 blurp kernel: invalid operand: 0000
> > > Dec 14 02:27:35 blurp kernel: CPU:    0
> > > Dec 14 02:27:35 blurp kernel: EIP:    0010:[kmem_extra_free_checks+81/140] Not tainted
> > [...]
> > > Dec 14 02:27:35 blurp kernel: Process rmmod (pid: 110, stackpage=cc045000)
> > [..]
> > > Dec 14 02:27:35 blurp kernel: Call Trace:
>
>
> 	Where is this comming from ? Was it sent to the IrDA mailing list ?

It was originally sent to lkml and Dag (email taken from irlan sources).
Now I reposted it also to irda-linux.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku
http://tfuj.pl/cv.html :: http://tfuj.pl/pgp.asc


