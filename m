Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267229AbSLKRHI>; Wed, 11 Dec 2002 12:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267225AbSLKRHI>; Wed, 11 Dec 2002 12:07:08 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:38534 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S267229AbSLKRHG>; Wed, 11 Dec 2002 12:07:06 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 11 Dec 2002 09:16:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Robert Love <rml@tech9.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] epoll: don't printk pointer value
In-Reply-To: <1039588045.833.3.camel@phantasy>
Message-ID: <Pine.LNX.4.50.0212110915030.2279-100000@blue1.dev.mcafeelabs.com>
References: <1039588045.833.3.camel@phantasy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2002, Robert Love wrote:

> Davide,
>
> I really cannot think of a good reason why eventpoll_init() should print
> a pointer value to user-space - especially the value of current?
>
> I do not think this is good practice and someone might even consider it
> a security hole.  Personally, I would prefer to remove the "successfully
> initialized" message altogether, but at the very least can we not print
> current's address?

It's ok Robert, it was used for debugging purposes and now it can be
completely removed ( the whole printk() ). I'll post a patch to Linus that
removes the printk() ...



- Davide

