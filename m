Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310302AbSCBD5l>; Fri, 1 Mar 2002 22:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310303AbSCBD5a>; Fri, 1 Mar 2002 22:57:30 -0500
Received: from ns.crrstv.net ([209.128.25.4]:52660 "EHLO mail.crrstv.net")
	by vger.kernel.org with ESMTP id <S310302AbSCBD5I>;
	Fri, 1 Mar 2002 22:57:08 -0500
Date: Fri, 1 Mar 2002 23:56:51 -0400 (AST)
From: skidley <skidley@crrstv.net>
X-X-Sender: skidley@localhost.localdomain
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19pre2-ac1
In-Reply-To: <20020302025013.GA1600@matchmail.com>
Message-ID: <Pine.LNX.4.43.0203012351360.1612-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Mike Fedyk wrote:

> On Sat, Mar 02, 2002 at 02:09:46AM +0000, Alan Cox wrote:
> > This one is a bit more experimental. I've avoided putting too much in so
> > we can see how the O(1) scheduler pans out.
> > 
> 
> --- linux.19p2/Makefile Fri Mar  1 18:26:30 2002
> +++ linux.19pre2-ac1/Makefile   Fri Mar  1 18:41:22 2002
> @@ -1,7 +1,7 @@
>  VERSION = 2
>  PATCHLEVEL = 4
>  SUBLEVEL = 19
> -EXTRAVERSION = -pre2
> +EXTRAVERSION = -pre1-ac3
>  
>  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
> 
> Ehh, a little problem here. :(
> 
> It does apply and compile on top of pre2, but uname -r will say different.
> 
I just changed the Makefile here, note my signature (uname -a)

I was wondering about the new Machine Check Exception Option added with
this patch. where can I get info(if there is any) on using it, re the boot option to use the Mb's it supports and any userland stuff if any.
-- 
"With a name like Black Sabbath, we'd look a right bunch of idiots standing 
there with a flower in our hands." -- Ozzy Osbourne

Chad Young           
Registered Linux User #195191
@ http://counter.li.org
-----------------------------------------------------------------------
Linux localhost 2.4.19-pre2-ac1 #1 Fri Mar 1 23:14:20 AST 2002 i686 unknown
 11:50pm  up 3 min,  1 user,  load average: 0.24, 0.15, 0.05

