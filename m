Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbRH0TcH>; Mon, 27 Aug 2001 15:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266864AbRH0Tb5>; Mon, 27 Aug 2001 15:31:57 -0400
Received: from freeside.toyota.com ([63.87.74.7]:37130 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S266797AbRH0Tbx>; Mon, 27 Aug 2001 15:31:53 -0400
Message-ID: <3B8AA02D.6F7561AB@lexus.com>
Date: Mon, 27 Aug 2001 12:31:57 -0700
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Cliff Albert <cliff@oisec.net>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Updated Linux kernel preemption patches
In-Reply-To: <998877465.801.19.camel@phantasy> <20010827093835.A15153@oisec.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the same error -

RH 7.1 + updates and bits of rawhide -


Cliff Albert wrote:

> On Sun, Aug 26, 2001 at 09:57:43PM -0400, Robert Love wrote:
>
> > Available at:
> >
> > http://tech9.net/rml/linux/patch-rml-2.4.9-preempt-kernel-1
> > http://tech9.net/rml/linux/patch-rml-2.4.8-ac12-preempt-kernel-1
> >
> > for kernel 2.4.9 and 2.4.8-ac12, respectively.
> >
> > This is a straight update of Nigel Gamble's Linux kernel preemption
> > patch from http://kpreempt.sourceforge.net, updated for the above
> > kernels.  Thus, this is Nigel's code -- I merely updated it.
> >
> > I am eager to see work done on the patch and to see what its future may
> > be.  If you are in any way interested in application latency or
> > real-time support, I suggest you check this out.  If you are just
> > curious, its an interesting patch none-the-less.
>
> Kernel won't compile when this patch is applied to 2.4.8-ac12
>
> kernel/kernel.o: In function `mmput':
> kernel/kernel.o(.text+0x1853): undefined reference to `atomic_dec_and_lock'
> kernel/kernel.o: In function `free_uid':
> kernel/kernel.o(.text+0xaea0): undefined reference to `atomic_dec_and_lock'
> fs/fs.o: In function `kill_super':
> fs/fs.o(.text+0x7002): undefined reference to `atomic_dec_and_lock'
> fs/fs.o: In function `dput':
> fs/fs.o(.text+0x13365): undefined reference to `atomic_dec_and_lock'
> fs/fs.o: In function `iput':
> fs/fs.o(.text+0x15ed2): undefined reference to `atomic_dec_and_lock'
>
> --
> Cliff Albert            | RIPE:      CA3348-RIPE | www.oisec.net
> cliff@oisec.net         | 6BONE:     CA2-6BONE   | icq 18461740
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

