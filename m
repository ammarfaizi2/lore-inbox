Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316679AbSE3PHE>; Thu, 30 May 2002 11:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSE3PHD>; Thu, 30 May 2002 11:07:03 -0400
Received: from vivi.uptime.at ([62.116.87.11]:29859 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S316679AbSE3PHB>;
	Thu, 30 May 2002 11:07:01 -0400
Message-ID: <010001c207ec$9b03f7c0$3d01a8c0@pitzeier.priv.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <000901c20654$0e215440$010b10ac@sbp.uptime.at>
Subject: Re: kernel 2.5.18 on alpha
Date: Thu, 30 May 2002 17:13:51 +0200
Organization: UPtime system solutions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there really nobody who can help me with this error?

Greetz,
  Oliver

----- Original Message -----
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, May 28, 2002 4:29 PM
Subject: kernel 2.5.18 on alpha


> Hi volks!
>
> I get this error when trying to compile kernel 2.5.18 on alpha.
>
> Please help me!
>
> [ ... ]
> gcc -D__KERNEL__ -I/root/linux-2.5.18/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5 -Wa,-mev6
> -DKBUILD_BASENAME=do_mounts  -c -o do_mounts.o do_mounts.c
> In file included from /root/linux-2.5.18/include/linux/thread_info.h:10,
>                  from /root/linux-2.5.18/include/linux/spinlock.h:7,
>                  from /root/linux-2.5.18/include/linux/tqueue.h:16,
>                  from /root/linux-2.5.18/include/linux/sched.h:10,
>                  from do_mounts.c:4:
> /root/linux-2.5.18/include/linux/bitops.h: In function
> `get_bitmask_order':
> /root/linux-2.5.18/include/linux/bitops.h:77: warning: implicit
> declaration of function `fls'
> In file included from do_mounts.c:13:
> /root/linux-2.5.18/include/linux/suspend.h:4:25: asm/suspend.h: No such
> file or directory
> make[1]: *** [do_mounts.o] Error 1
> make[1]: Leaving directory `/root/linux-2.5.18/init'
> make: *** [_dir_init] Error 2
> [ ... ]
>
> Greetz,
>  Oliver
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

