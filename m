Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSEaIJQ>; Fri, 31 May 2002 04:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSEaIJQ>; Fri, 31 May 2002 04:09:16 -0400
Received: from vivi.uptime.at ([62.116.87.11]:29604 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S315200AbSEaIJO>;
	Fri, 31 May 2002 04:09:14 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <axp-kernel-list@redhat.com>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Cc: <alan@lxorguk.ukuu.org.uk>, <torvalds@transmeta.com>,
        "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>
Subject: RE: kernel 2.5.19 on an alpha
Date: Fri, 31 May 2002 10:07:58 +0200
Organization: =?US-ASCII?Q?UPtime_Systemlosungen?=
Message-ID: <000301c2087a$49b0c8b0$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <000201c20879$cbd73960$010b10ac@sbp.uptime.at>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PLS HELP ME!

-Oliver

> Hi volks/Linus/Alan/Ivan! :o)
> 
> I tried to compile kernel 2.5.19 on an alpha.
> 
> Can someone help me? I had the same problem already with 
> kernel 2.5.18. Kernel 2.5.15 works well. Everything above _not_.
> 
> Please help!!! Thanks!
> 
> While trying to compile 2.5.19, this happens:
> <snip>
> make[2]: Entering directory `/root/linux-2.5.19/drivers/base' 
> gcc -D__KERNEL__ -I/root/linux-2.5.19/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 
> -mcpu=ev5 -Wa,-mev6 -DKBUILD_BASENAME=bus -DEXPORT_SYMTAB -c 
> -o bus.o bus.c In file included from 
> /root/linux-2.5.19/include/linux/thread_info.h:10,
>                  from /root/linux-2.5.19/include/linux/spinlock.h:7,
>                  from /root/linux-2.5.19/include/linux/tqueue.h:16,
>                  from /root/linux-2.5.19/include/linux/sched.h:10,
>                  from /root/linux-2.5.19/include/linux/device.h:30,
>                  from bus.c:12:
> /root/linux-2.5.19/include/linux/bitops.h: In function
> `get_bitmask_order':
> /root/linux-2.5.19/include/linux/bitops.h:77: warning: 
> implicit declaration of function `fls'
> bus.c: At top level:
> bus.c:114: parse error before `bus_init'
> bus.c:115: warning: return type defaults to `int'
> bus.c:120: warning: type defaults to `int' in declaration of 
> `core_initcall'
> bus.c:120: warning: parameter names (without types) in 
> function declaration
> bus.c:120: warning: data definition has no type or storage class
> make[2]: *** [bus.o] Error 1
> make[2]: Leaving directory `/root/linux-2.5.19/drivers/base'
> make[1]: *** [_subdir_base] Error 2
> make[1]: Leaving directory `/root/linux-2.5.19/drivers'
> make: *** [drivers] Error 2
> <snip>
> 
> Best regards,
>   Greetz to the community,
>     Oliver
> 
> 
> 
> 
> _______________________________________________
> Axp-kernel-list mailing list
> Axp-kernel-list@redhat.com 
> https://listman.redhat.com/mailman/listinfo/ax> p-kernel-list
> 


