Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSKRVXm>; Mon, 18 Nov 2002 16:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSKRVXm>; Mon, 18 Nov 2002 16:23:42 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:5767 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264822AbSKRVXk>; Mon, 18 Nov 2002 16:23:40 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 13:31:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ulrich Drepper <drepper@redhat.com>
cc: Mark Mielke <mark@mark.mielke.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <3DD946A2.7030501@redhat.com>
Message-ID: <Pine.LNX.4.44.0211181324060.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Ulrich Drepper wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Davide Libenzi wrote:
>
> > epoll does hook f_op->poll() and hence uses the asm/poll.h bits.
>
> It does today.  We are talking about "you promise that this will be the
> case ever after or we'll cut your head off".  I have no idea why you're
> so reluctant since you don't have to maintain any of the user-level
> bits.  And it is not you who has to deal with the fallout of a change
> when it happens.
>
> If epoll is so different from poll (and this is what I've been told frmo
> Davide) then there should be a clear separation of the interfaces and
> all those arguing to unify the data types and constants better should
> rethink there understanding.

Ok, the message has been post and noone argued about your solution. Like
it is used to say "speak now or forever hold your piece" :) So we will go
with it, no problem for me. We will define a struct epollfd and all POLL*
bits in EPOLL*




- Davide




