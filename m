Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269257AbRIHM7O>; Sat, 8 Sep 2001 08:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269354AbRIHM7E>; Sat, 8 Sep 2001 08:59:04 -0400
Received: from kiln.isn.net ([198.167.161.1]:3688 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S269257AbRIHM6v>;
	Sat, 8 Sep 2001 08:58:51 -0400
Message-ID: <3B9A15BC.46DB90BF@isn.net>
Date: Sat, 08 Sep 2001 09:57:32 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.10-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.4.10-pre5
In-Reply-To: <3B99A8C2.56E88CE3@isn.net> <m2lmjq7yuv.fsf@ppro.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> 
> "Garst R. Reese" <reese@isn.net> writes:
> 
> > Garstmake[2]: Entering directory `/usr/src/linux/drivers/block'
> > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE   -c -o rd.o rd.c
> > rd.c: In function `rd_ioctl':
> > rd.c:262: invalid type argument of `->'
> > rd.c: In function `rd_cleanup':
> > rd.c:375: too few arguments to function `blkdev_put'
> > make[2]: *** [rd.o] Error 1
> > make[2]: Leaving directory `/usr/src/linux/drivers/block'
> > make[1]: *** [_modsubdir_block] Error 2
> > make[1]: Leaving directory `/usr/src/linux/drivers'
> > make: *** [_mod_drivers] Error 2
> > Command exited with non-zero status 2
> 
> This patch seems to work:
Yes, it compiled, but Netscape-4.75 either kills it, or locks up.
So there are other problems.
Nothing in logs. booting back to pre2 is ok
Garst
