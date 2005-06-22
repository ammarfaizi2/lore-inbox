Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVFVTPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVFVTPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 15:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVFVTPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 15:15:47 -0400
Received: from adsl-68-248-203-41.dsl.milwwi.ameritech.net ([68.248.203.41]:47299
	"EHLO eagle.netwrx1.com") by vger.kernel.org with ESMTP
	id S261897AbVFVTP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 15:15:26 -0400
Date: Wed, 22 Jun 2005 14:15:25 -0500 (CDT)
From: George Kasica <georgek@netwrx1.com>
To: Adrian Bunk <bunk@stusta.de>
cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem compiling 2.6.12
In-Reply-To: <20050622164436.GI3705@stusta.de>
Message-ID: <Pine.LNX.4.62.0506221414380.25918@eagle.netwrx1.com>
References: <Pine.LNX.4.62.0506221026130.4837@eagle.netwrx1.com>
 <9a874849050622085975b67c06@mail.gmail.com> <20050622164436.GI3705@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian:

I tried the new 2.6.12 config as suggested by Jesper earlier and got this 
asa result(Not much better):

[root@eagle linux]# make bzImage
   CHK     include/linux/version.h
   SPLIT   include/linux/autoconf.h -> include/config/*
   HOSTCC  scripts/mod/sumversion.o
In file included from /usr/include/linux/errno.h:4,
                  from /usr/local/include/bits/errno.h:25,
                  from /usr/local/include/errno.h:36,
                  from scripts/mod/sumversion.c:8:
/usr/include/asm/errno.h:4: asm-generic/errno.h: No such file or directory
make[2]: *** [scripts/mod/sumversion.o] Error 1
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2


George

On Wed, 22 Jun 2005, Adrian Bunk wrote:

> On Wed, Jun 22, 2005 at 05:59:45PM +0200, Jesper Juhl wrote:
>>
>> Don't use a 2.4.x config as the basis for a 2.6.x kernel .
>> Build your first 2.6.x kernel config using "make menuconfig", "make
>> config", make xconfig" or similar, /then/ you can use that config in
>> the future as a base for other 2.6.x kernels with "make oldconfig".
>
> First of all, this shouldn't result in problems like the one he
> reported (see my other mail).
>
> And I'm surprised you are saying this. I'd have expected that running
> "make oldconfig" with a 2.4 kernel should give him a working
> configuration.
>
> Can you explain where you'd expect problems so that we can fix them?
>
>> Jesper Juhl <jesper.juhl@gmail.com>
>
> cu
> Adrian
>
> -- 
>
>       "Is there not promise of rain?" Ling Tan asked suddenly out
>        of the darkness. There had been need of rain for many days.
>       "Only a promise," Lao Er said.
>                                       Pearl S. Buck - Dragon Seed
>
>
