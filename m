Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318809AbSIITye>; Mon, 9 Sep 2002 15:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318810AbSIITye>; Mon, 9 Sep 2002 15:54:34 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:64997 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318809AbSIITyc>;
	Mon, 9 Sep 2002 15:54:32 -0400
Date: Mon, 9 Sep 2002 12:59:11 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.34
Message-ID: <20020909195911.GA28663@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabor Z. Papp wrote :
> gcc 2.95.4-cvs
> GNU ld version 2.12.90.0.4 20020408
> 
> make[3]: Entering directory `/usr/src/linux-2.5.34/drivers/net/irda'
>   gcc -Wp,-MD,./.irtty.o.d -D__KERNEL__ -I/usr/src/linux-2.5.34/include -Wall \
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing \
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix \
>                 include -DMODULE   -DKBUILD_BASENAME=irtty   -c -o irtty.o irtty.c
> irtty.c: In function `irtty_cleanup':
> irtty.c:121: called object is not a function
> irtty.c:122: parse error before string constant
> irtty.c: In function `irtty_open':
> irtty.c:229: called object is not a function
> irtty.c:229: parse error before string constant
> irtty.c:248: called object is not a function
> irtty.c:248: parse error before string constant
> irtty.c: In function `irtty_change_speed':
> irtty.c:454: called object is not a function
> irtty.c:455: parse error before string constant
> irtty.c:466: called object is not a function
> irtty.c:466: parse error before string constant
> make[3]: *** [irtty.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5.34/drivers/net/irda'
> make[2]: *** [irda] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.5.34/drivers/net'
> make[1]: *** [net] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.34/drivers'
> make: *** [drivers] Error 2

	That's new. I'll try to investigate and make a patch soon, but
I'm busy. As my patches don't seem to go in the kernel, just visit my
web page in a few days.
	Thanks...

	Jean
