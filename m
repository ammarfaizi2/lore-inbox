Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279512AbRJXKPT>; Wed, 24 Oct 2001 06:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279509AbRJXKO7>; Wed, 24 Oct 2001 06:14:59 -0400
Received: from mgw-x2.nokia.com ([131.228.20.22]:25567 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S279507AbRJXKOz>;
	Wed, 24 Oct 2001 06:14:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andy Pevy <andy.pevy@nokia.com>
Reply-To: andy.pevy@nokia.com
To: "ext =?iso-8859-1?q?	Linus?= Torvalds" <torvalds@transmeta.com>,
        "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.13..
Date: Wed, 24 Oct 2001 11:16:17 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15wM1B-0001Ne-00@fa1ntd0754.europe.nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 October 2001 5:52 am, ext 	Linus Torvalds wrote:
> Things seem to be calming down a bit, which is nice.
>
> Of course, it might possibly also be that everybody is off flaming about
> the DMCA and getting no work done ;)
>
> Whatever the cause, here's a 2.4.13. See if you can break it,
>
> 		Linus
>

I cannot even build it :-((

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
-include /usr/src/linux/include/linux/modversions.h   -c -o cpqfcTSinit.o 

cpqfcTSinit.c
cpqfcTSinit.c: In function `cpqfcTS_ioctl':
cpqfcTSinit.c:663: `SCSI_IOCTL_FC_TARGET_ADDRESS' undeclared (first use in 
this function)
cpqfcTSinit.c:663: (Each undeclared identifier is reported only once
cpqfcTSinit.c:663: for each function it appears in.)
cpqfcTSinit.c:681: `SCSI_IOCTL_FC_TDR' undeclared (first use in this function)
make[2]: *** [cpqfcTSinit.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2
capc1540:/usr/src/linux #

EEK ....

Andy Pevy


