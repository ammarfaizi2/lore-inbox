Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290333AbSBKUoV>; Mon, 11 Feb 2002 15:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290310AbSBKUoQ>; Mon, 11 Feb 2002 15:44:16 -0500
Received: from Expansa.sns.it ([192.167.206.189]:32019 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S290361AbSBKUoE>;
	Mon, 11 Feb 2002 15:44:04 -0500
Date: Mon, 11 Feb 2002 21:42:09 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Robert Love <rml@tech9.net>
cc: Arkadiy Chapkis - Arc <achapkis@mail.dls.net>,
        <LINUX-KERNEL@vger.kernel.org>
Subject: Re: thread_info implementation
In-Reply-To: <1013458767.6785.459.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0202112140280.6590-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 11 Feb 2002, Robert Love wrote:

> On Mon, 2002-02-11 at 12:39, Arkadiy Chapkis - Arc wrote:
>
> > In file included from
> > /usr/local/src/test/linux-2.5.4/include/linux/spinlock.h:7,
> >                  from
> > /usr/local/src/test/linux-2.5.4/include/linux/module.h:11,
> >                  from loop.c:55:
> > /usr/local/src/test/linux-2.5.4/include/linux/thread_info.h:10:29:
> > asm/thread_info.h: No such file or directory
>
> This is known.  I don't believe any arches except i386 and SPARC64 are
> using the new thread_info / task_struct implementation introduced during
> 2.5.4-pre.
You are optimist.
I could not manage to make my sparc64 boot with 2.5.3+ kernels.
Now, Actually my problem is reiserFS on sparc64 (I already posted about
this). Let's hope I could run 2.5 on sparc64 soon ;)

Luigi

>
> I think I saw some changesets from Jeff Garzik wrt alpha thread_info
> support, so perhaps in 2.5.5-pre1.
>
> 	Robert Love
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

