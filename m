Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbRFUWa1>; Thu, 21 Jun 2001 18:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265267AbRFUWaR>; Thu, 21 Jun 2001 18:30:17 -0400
Received: from helios.jpl.nasa.gov ([137.78.79.47]:23247 "EHLO
	helios.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id <S265266AbRFUWaD>; Thu, 21 Jun 2001 18:30:03 -0400
Message-ID: <3B3274F2.56FAB826@telerobotics.jpl.nasa.gov>
Date: Thu, 21 Jun 2001 15:28:02 -0700
From: Chris Leger <cleger@helios.jpl.nasa.gov>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual address 
 - 2.4.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the same problem, only mine occurs early in the boot process
(right after a message saying something like "trying to mount old
root..."; or maybe s/mount/unmount)so I don't have a log.  I have a
similar system: dual PIIIs w/ Adaptec AIC-7xxx controller, an HP Kayak. 
I saw some earlier messages about AIC-7xxx problems w/ 2.4.5, so I tried
using aic7xxx_old and also tried a patch someone mentioned.  I have yet
to be able to bring up my machine with 2.4.5 under any combination of
aic7xxx drivers, so maybe it's not the driver after all.

Any ideas?  I built the kernel w/ gcc 2.91.66 (kgcc).

Thanks,

Chris Leger

Rafael Martinez writes:
> Hello
>
>     I have got a error in my syslog about a Null pointer in the kernel:
>
>     Kernel 2.4.5
>     glibc 2.2.12
>     gcc version 2.96 20000731 (Red Hat Linux 7.0)
>
>     Modell: ISP2150 
>     Motherboard: L440GX+ DP 
>     CPU: 2 x Intel Pentium III (Coppermine) 850 MHz L2 cache: 256K / Bus: 100 MHz 
>     RAM: 256 MB 
>     SCSI controller: Adaptec AIC-7896/7 Ultra2
>
>Unable to handle kernel NULL pointer dereference at virtual address
>     00000015
>      printing eip:
>     c014db72
>     *pde = 00000000
>     Oops: 0002
>     CPU:    1
>     EIP:    0010:[<c014db72>]
>     EFLAGS: 000

-- 
[ Chris Leger  ::  cleger@robotics.jpl.nasa.gov   (818)393-4462 ]

You can come up with a hundred reasons why a thing can't be done, 
and you have to eat them all when someone else does it.
