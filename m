Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSCaAnr>; Sat, 30 Mar 2002 19:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310241AbSCaAnh>; Sat, 30 Mar 2002 19:43:37 -0500
Received: from c9mailgw04.amadis.com ([216.163.188.207]:62982 "EHLO
	C9Mailgw07.amadis.com") by vger.kernel.org with ESMTP
	id <S310206AbSCaAnT>; Sat, 30 Mar 2002 19:43:19 -0500
Message-ID: <3CA65B98.9A787386@starband.net>
Date: Sat, 30 Mar 2002 19:43:04 -0500
From: Justin Piszcz <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.18 [link error]
In-Reply-To: <11595.1017533537@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.
I thought I could get away with a make config, and not a make oldconfig
first. :P

Keith Owens wrote:

> On Sat, 30 Mar 2002 17:26:43 -0500,
> Justin Piszcz <war@starband.net> wrote:
> >The .config is attached.
> >/usr/src/linux/arch/i386/lib/lib.a \
> >        --end-group \
> >        -o vmlinux
> >net/network.o(.text.lock+0x3a37): undefined reference to `local symbols
> >in discarded section .text.exit'
>
> Your .config is invalid for 2.4.18.  You did not run make *config
> before building the kernel[1], the results are undefined.
>
> [1] Guess why kbuild 2.5 checks if make *config has been run?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

