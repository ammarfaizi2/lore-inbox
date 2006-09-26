Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWIZFe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWIZFe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWIZFe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:34:56 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:29830 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751268AbWIZFez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:34:55 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 25 Sep 2006 22:34:46 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: [patch] epoll_pwait for 2.6.18 ...
In-Reply-To: <20060925200419.85aa4ff6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609252232110.10839@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0609251735070.4749@alien.or.mcafeemobile.com>
 <20060925200419.85aa4ff6.akpm@osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006, Andrew Morton wrote:

> On Mon, 25 Sep 2006 17:43:10 -0700 (PDT)
> Davide Libenzi <davidel@xmailserver.org> wrote:
>
>>
>> The attached patch implements the epoll_pwait system call
>
> Your email client space-stuffed it.  That's pretty easy to fix up, but...

Damn Pine!


>> arch/i386/kernel/syscall_table.S |    1
>> fs/eventpoll.c                   |   55 ++++++++++++++++++++++++++++++++++++---
>> include/asm-i386/unistd.h        |    3 +-
>> include/linux/syscalls.h         |    3 ++
>
> Could you please also wire up x86_64, so we can keep the 32-bit syscall
> numbers in sync?  I guess we should do arch/ia64/ia32/ia32_entry.S too, but
> people don't seem to do that.

Ack. Will repost tomorrow ...


- Davide


