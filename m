Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131825AbRAaUJz>; Wed, 31 Jan 2001 15:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131627AbRAaUJo>; Wed, 31 Jan 2001 15:09:44 -0500
Received: from jalon.able.es ([212.97.163.2]:53496 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131088AbRAaUJf>;
	Wed, 31 Jan 2001 15:09:35 -0500
Date: Wed, 31 Jan 2001 21:09:26 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Lukasz Gogolewski <lucas@supremedesigns.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with compiling kernel 2.4.1 on top of 2.2.14
Message-ID: <20010131210926.A6530@werewolf.able.es>
In-Reply-To: <3A7840C8.17841498@supremedesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A7840C8.17841498@supremedesigns.com>; from lucas@supremedesigns.com on Wed, Jan 31, 2001 at 17:43:52 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.31 Lukasz Gogolewski wrote:
> Hello,
> 
> Just recently I've tried to compile kernel 2.4.1 on my RH 6.2 machine
> that runs 2.2.14.
> All my utilities needed in order to compile that kernel are up to date.
> 
> When I got thru xmake config and I configure all the options. I try to
> compile it.
> 
> When I do make dep I dont' get any error messages.
> 
> When I do either make bzImage or make zImage I get the following errors
> at the very beginning:
> 
> 
>                  from /usr/src/linux/include/asm/hardirq.h:6,
>                  from /usr/src/linux/include/linux/interrupt.h:45,
>                  from /usr/src/linux/include/asm/string.h:296,
>                  from /usr/src/linux/include/linux/string.h:21,
>                  from /usr/src/linux/include/linux/fs.h:23,
>                  from /usr/src/linux/include/linux/capability.h:17,
>                  from /usr/src/linux/include/linux/binfmts.h:5,
>                  from /usr/src/linux/include/linux/sched.h:9,
>                  from /usr/src/linux/include/linux/mm.h:4,
>                  from /usr/src/linux/include/linux/slab.h:14,
>                  from /usr/src/linux/include/linux/malloc.h:4,
>                  from /usr/src/linux/include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> /usr/src/linux/include/asm/hw_irq.h:198: `current' undeclared (first use
> in this function)

Are you building a K6-2 or K-7 with SMP config ?

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-zcn #1 SMP Tue Jan 30 11:38:19 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
