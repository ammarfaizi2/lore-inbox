Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbSKKSfu>; Mon, 11 Nov 2002 13:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265869AbSKKSfu>; Mon, 11 Nov 2002 13:35:50 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:31365 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264990AbSKKSft>; Mon, 11 Nov 2002 13:35:49 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 11 Nov 2002 10:42:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] epoll bits 0.34
In-Reply-To: <3DCFF273.4020403@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0211111042131.1797-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2002, Manfred Spraul wrote:

> Which file descriptors are pollable with eventpoll? For example rtc_poll
> does
>
>     spin_lock_irq();
>     do_work();
>     spin_unlock_irq();
>
> I'm sure that there are other drivers that are be affected, I haven't
> checked networking.
>
> And is that really needed? Could you do the real work in the poll
> callback instead of locking around the f_op call?

I'll take care of it, thx for your precious input.



- Davide


