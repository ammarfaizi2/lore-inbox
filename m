Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263454AbTJQPrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 11:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbTJQPrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 11:47:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14209 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263454AbTJQPrp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 11:47:45 -0400
Date: Fri, 17 Oct 2003 11:49:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Suresh Subramanian <Suresh.Subramanian@lntinfotech.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: killing a kernel thread.
In-Reply-To: <1066405067.6744.1444.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.53.0310171143450.3689@chaos>
References: <OFE97AECC7.A7E1AF0C-ON65256DC2.0046781F@lntinfotech.com> 
 <Pine.LNX.4.53.0310170950290.3209@chaos> <1066405067.6744.1444.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003, David Woodhouse wrote:

> Ooh ooh RBJcode. I'm going to be fair and only pick one of the errors,
> leaving many more for others to play the game too...
>
>
> On Fri, 2003-10-17 at 09:51 -0400, Richard B. Johnson wrote:
>
> >   __u32 volatile status;
>
> >   while (!test_bit(0,&priv->status)) {
>
> test_bit() and friends work on 'unsigned long' not uint32_t.
>
> --
> dwmw2
>

Well it isn't RBJcode. It's Intel code. Look who wrote it
before you give me any credit, especially your kind of "credit".

Also, Intel machines have 32-bit longs which are identical to
32-bit ints and this was an Intel driver........

Have fun growing up.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


