Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVDEOix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVDEOix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVDEOix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:38:53 -0400
Received: from alog0090.analogic.com ([208.224.220.105]:56503 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261765AbVDEOik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:38:40 -0400
Date: Tue, 5 Apr 2005 10:38:00 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: John M Flinchbaugh <john@hjsoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: debug: sleeping function...slab.c:2090
In-Reply-To: <20050405142836.GA25571@butterfly.hjsoft.com>
Message-ID: <Pine.LNX.4.61.0504051036440.16098@chaos.analogic.com>
References: <20050405142836.GA25571@butterfly.hjsoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, John M Flinchbaugh wrote:

> I got the debug statement below during boot.
>
> Environment:
>    Pentium M, Thinkpad R40
>    Debian unstable
>    Linux 2.6.12-rc2
>    Gnu C 3.3.5
>    binutils 2.15
>
> Debug: sleeping function called from invalid context at mm/slab.c:2090
> in_atomic():1, irqs_disabled():0
> [<c0103707>] dump_stack+0x17/0x20
> [<c0114e6c>] __might_sleep+0xac/0xc0
> [<c014394e>] kmem_cache_alloc+0x5e/0x60
> [<c0142aa3>] kmem_cache_create+0xe3/0x570
> [<c0268d39>] proto_register+0x99/0xc0
> [<e0bea096>] inet6_init+0x16/0x1d0 [ipv6]
> [<c0132902>] sys_init_module+0x172/0x230
> [<c01030e5>] syscall_call+0x7/0xb
>
> -- 
> John M Flinchbaugh
> john@hjsoft.com
>

What module was being loaded at the time?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
