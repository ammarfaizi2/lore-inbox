Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293022AbSBVWI5>; Fri, 22 Feb 2002 17:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293023AbSBVWIs>; Fri, 22 Feb 2002 17:08:48 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21890 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293022AbSBVWIh>; Fri, 22 Feb 2002 17:08:37 -0500
Date: Fri, 22 Feb 2002 17:10:13 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dan Aloni <da-x@gmx.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] C exceptions in kernel
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org>
Message-ID: <Pine.LNX.3.95.1020222170712.9509A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Feb 2002, Dan Aloni wrote:

> The attached patch implements C exceptions in the kernel, which *don't*
> depend on special support from the compiler. This is a 'request for
> comments'. The patch is very initial, should not be applied.
> 
> I actually got this code to work in the kernel:
> 
>         try {
>                 printk("TEST: before throwing \n");
>                 throw(1000);
>                 printk("TEST: won't run\n");
>         }
>         catch(unsigned long, value) {
>                 printk("TEST: caught: %ld\n", value);
>         } yrt;
> 

What is this supposed to do?  Are these a bunch of solutions waiting
for a problem? Or is my Calendar wrong?


Cheers,

Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

