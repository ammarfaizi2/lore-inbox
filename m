Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131552AbQLMW6H>; Wed, 13 Dec 2000 17:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbQLMW57>; Wed, 13 Dec 2000 17:57:59 -0500
Received: from [209.143.110.29] ([209.143.110.29]:35079 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S129803AbQLMW5m>; Wed, 13 Dec 2000 17:57:42 -0500
Message-ID: <3A37F7B7.1A207AB7@the-rileys.net>
Date: Wed, 13 Dec 2000 17:27:03 -0500
From: David Riley <oscar@the-rileys.net>
Organization: The Riley Family
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Macok <martin.macok@underground.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12 randomly hangs up
In-Reply-To: <20001213105153.A6624@sarah.kolej.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Macok wrote:
> 
> Hi,
> after 1-3 hours with -test12 system hangs up with
>  - no response from mouse
>  - no response from keyboard (no sysrq, only sysrq+'b' works ...)
>  - no response from network (ICMP, TCP)
>  - nothing on console, nothing in logs (ie. nothing interesting or relevant
>    to crash).
> 
> System was not under load (1 user, X, no swapping ...)
> 
> ( -test11 was up for 3 weeks with no problems and so do 2.2.17 ... )
> 
> slightly modified Red Hat 7.0:
> 
> Linux sarah.xxxxxxxxxxxxxxxxx 2.4.0-test11 #4 Sat Dec 9 14:24:20 CET
> 2000 i586 unknown
> Kernel modules         2.3.21
> Gnu C                  2.96
> Gnu Make               3.79.1
> Binutils               2.10.0.18
> Linux C Library        > libc.2.2
> Dynamic linker         ldd (GNU libc) 2.2
> Procps                 2.0.7
> Mount                  2.10m
> Net-tools              1.56
> Console-tools          0.3.3
> Sh-utils               2.0
> Modules Loaded         nls_iso8859-2 nls_cp852 vfat mad16 ad1848 sb_lib
>                         uart401
> 
> DMESG:   http://kocour.ms.mff.cuni.cz/~macok/kernel/dmesg
> (Abit PX5, P166 (ovrclckd to 166), 128MB RAM, 2x IDE HDD, 3com509b ISA, Opti931)

Overclocking is a guaranteed way to get random hangups.  Put it back to
its recommended clock and it might work fine.  Keep in mind that while
this may not have shown up before, overclocking gradually degrades a
processor's stability (trust me, I ran several 486 and pentiums and even
a k6-2 down to where they wouldn't even work at the normal clock).  Try
sticking it back to normal.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
