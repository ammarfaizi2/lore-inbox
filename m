Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbSKJVvY>; Sun, 10 Nov 2002 16:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSKJVvY>; Sun, 10 Nov 2002 16:51:24 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:44684 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265190AbSKJVvX>; Sun, 10 Nov 2002 16:51:23 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 10 Nov 2002 14:08:13 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC,PATCH] poll cleanup 2/3
In-Reply-To: <3DCE435D.10604@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0211101407360.7415-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Nov 2002, Manfred Spraul wrote:

> Change 2:
> split the poll_table structure into 2 parts:
> One global part with just a function pointer and a priv variable.
> The 2nd part is user specific:
> for __pollwait: the poll table and the error variable
> for ep_ptable_queue_proc: the pointer to the eventpoll data.
>
> This change is a prerequisite for the next patch, that embedds a few
> waitqueues in the __pollwait specific part of the poll structure.

Manfred, I can ack this with the changes I told you inside fs/eventpoll.c



- Davide


