Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261478AbSJ2C3F>; Mon, 28 Oct 2002 21:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSJ2C3F>; Mon, 28 Oct 2002 21:29:05 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:59037 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261478AbSJ2C3E>; Mon, 28 Oct 2002 21:29:04 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 18:44:50 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021029020545.GD18727@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0210281844040.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Jamie Lokier wrote:

> >
> >         2) epoll must be used on non-blocking sockets only
> >               (and describe the race that happens otherwise)
>
> That much is implied simply by epoll being a queue of not_ready->ready
> edge transitions.  It would be good for the manual to explain this,
> but it is clearly implied by the API if you think about it.

Bert and Hanna are working on man pages right now with the aim of adding
those notes ...



- Davide


