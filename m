Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSKUBqH>; Wed, 20 Nov 2002 20:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264629AbSKUBqH>; Wed, 20 Nov 2002 20:46:07 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:13701 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262859AbSKUBqG>; Wed, 20 Nov 2002 20:46:06 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 20 Nov 2002 17:53:48 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hanna Linder <hannal@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC,PATCH] remove extra sys_ in epoll system call
In-Reply-To: <58880000.1037843786@w-hlinder>
Message-ID: <Pine.LNX.4.44.0211201752040.974-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Hanna Linder wrote:

>
> Davide,
>
> 	Is sys part of the name of epoll? That will make the
> system call actually sys_sys_epoll_*. This patch removes
> the extra sys in the places where it is not needed if that is
> the case. If it is supposed to be sys_sys then the asmlinkage
> calls should be changes to reflect that. Let me know what you
> think.

Thank you Hanna. It's fine. I'll feed this to Linus in my next patch.



- Davide


