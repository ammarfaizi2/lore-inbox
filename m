Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310816AbSCMQxO>; Wed, 13 Mar 2002 11:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310806AbSCMQxG>; Wed, 13 Mar 2002 11:53:06 -0500
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:61409 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S310813AbSCMQwu>; Wed, 13 Mar 2002 11:52:50 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: DaZZa <dazza@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel greater than 2.4.7
Date: Wed, 13 Mar 2002 17:52:40 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.30.0203121326420.12771-100000@zipperii.zip.com.au>
In-Reply-To: <Pine.LNX.4.30.0203121326420.12771-100000@zipperii.zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020313165240.428A8855@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 12. March 2002 03:35, DaZZa wrote:
>
> I'm attempting to compile a new kernel. 2.4.14 by preference, but this
> problem also exists with every version I've tried beyond 2.4.7.
>
> My box is running SuSE 7.2 Professional, pretty much standard - I haven't
> applied any updates from SuSE because I can't find any which seem relavent
> to my problem.

We're facing 8.0 now, the successor of 7.3...

> On installing a clean copy of the kernel source tree for ANY version after
> 2.4.7, I perform the following
>
> cd /usr/src

rm linux

> ln -s linux-2.4.14 linux
> cd linux
> make mrproper
> make menuconfig

[strange lxdialog problem]

> Can anyone shed some light on why this has become a problem _only_ since
> kernel version 2.4.7? Can anyone suggest some way I can make the compile
> work?
>
> Any assistance appreciated - I will try anything suggested along the way
> by anyone.
>
> Again, my apologies if this has gone to the wrong place.
>
> Thanks for any help received.
>
> DaZZa
>

Using SuSE since ages (4.3), I didn't came across this one...

Have a look in /usr/include/linux. They put some "standard" linux include
there :(. I've allways linked it to: 

# l -d /usr/include/linux
lrwxrwxrwx    1 root     root           26 10. Mär 15:34 /usr/include/linux 
-> ../src/linux/include/linux

strace is a pretty cool tool for this problem domain, btw ;)

Cheers,
  Hans-Peter
