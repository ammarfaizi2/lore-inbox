Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279959AbRJaKhZ>; Wed, 31 Oct 2001 05:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278842AbRJaKhP>; Wed, 31 Oct 2001 05:37:15 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:27149 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S279961AbRJaKhB>;
	Wed, 31 Oct 2001 05:37:01 -0500
Date: Wed, 31 Oct 2001 10:37:31 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender: <airlied@skynet>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: oops on 2.4.13-pre5 in prune_dcache
In-Reply-To: <200110310054.f9V0sEf01836@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.32.0110311032580.20516-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and because dentry->d_op isn't NULL, we oops on the d_op->d_iput
> dereference.
>
> Something is setting a bit in your dentry. Either RAM errors (do you
> have ECC memory or a history of SIGSEGV's to give any indication either
> way?) or a wild "set_bit()" pointer or similar.
>

well I've never seen any OOPS on this machine before or segv on this
machine and I use it for cross-compiling glibc/gdb/binutils/gcc/kernels
etc for the VAX port of Linux so I'm sure I'd have seen one before if it
was memory... I can run memtest on it at some stage over the next couple
of days but I'm pretty confident the RAM is okay.. granted its not ECC...

I have nothing unusual in my config I don't think,

ext2, nfsd, vfat, sb16, parport, ne2k-pci (x2 cards)...I can post my
.config later on today when I get back home..

Dave.


 >

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


