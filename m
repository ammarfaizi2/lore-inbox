Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266818AbSKHRU4>; Fri, 8 Nov 2002 12:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266819AbSKHRU4>; Fri, 8 Nov 2002 12:20:56 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:58760 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266818AbSKHRUz>; Fri, 8 Nov 2002 12:20:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 8 Nov 2002 09:37:35 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] epoll bits 0.30 ...
In-Reply-To: <20021108160955.GA30234@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211080937080.1768-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > Rusty, the hash is not under pressure over there. The only time seeks is
> > performed is at file removal ( from the set ) and eventually at file
> > modify. There's a direct link between the wait queue and its item during
> > the high frequency event delivery, so need seek is performed.
>
> It does seem peculiar to use a prime-sized hash table, though.  These
> days, good power-of-two-sized hash functions are well known.

To make everyone happy the latest code uses hash.h :)



- Davide


