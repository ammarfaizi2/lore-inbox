Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284289AbRLBTjl>; Sun, 2 Dec 2001 14:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284288AbRLBTjV>; Sun, 2 Dec 2001 14:39:21 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:18194 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284286AbRLBTjQ>; Sun, 2 Dec 2001 14:39:16 -0500
Date: Sun, 2 Dec 2001 11:49:53 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <008001c17b42$e2fa5880$30d8fea9@ecce>
Message-ID: <Pine.LNX.4.40.0112021148540.7375-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, [MOc]cda*mirabilos wrote:

> > > > movl %esp, %eax
> > > > andl $-8192, %eax
> > > > movl (%eax), %eax
> > >
> > > Although I'm good in assembly but bad in gas,
> > > do you consider the middle line good style?
> > >
> > > Binary AND with a negative decimal number?
> >
> > ~N = -(N + 1)
>
> I know, but I don't consider this good style, as
> decimal arithmetic is for humans, and binary
> {arithmetic,ops} are for the PC.

The better solution would be (STACK_SIZE - 1) but it's still decimal.



- Davide


