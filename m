Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268175AbRHAUzy>; Wed, 1 Aug 2001 16:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268182AbRHAUzo>; Wed, 1 Aug 2001 16:55:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9600 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268175AbRHAUzd>; Wed, 1 Aug 2001 16:55:33 -0400
Date: Wed, 1 Aug 2001 16:55:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Raghava Raju <vraghava_raju@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Basic question..
In-Reply-To: <20010801204401.21619.qmail@web20009.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1010801165338.3099A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Raghava Raju wrote:

> 
> 
>    Hi
> 
>         I am new to kernel programming. I have
>    just written a module consisting of init and
> cleanup
>    functions. I call init function of the module in
>    kernel initialization function. So when system
>    comes up, it shows that it entered module init 
>    function(printk in "init" print some string), but 
>    when I do lsmod it is not there in  list of 
>    modules. But if I do insmod module, the module is
>    listed in lsmod output. So is it that calling init
>    module and insmod are not equivalent?
> 
>    Thank You
>    Raghava.

If it's built into the kernel (a driver), it's not a module.
It won't show when executing `lsmod`. It also can't be removed.
Only drivers inserted as modules show with `lsmod`.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


