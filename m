Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272964AbRIHGRt>; Sat, 8 Sep 2001 02:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272963AbRIHGRi>; Sat, 8 Sep 2001 02:17:38 -0400
Received: from juicer47.bigpond.com ([144.135.25.134]:23522 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S272965AbRIHGR2>; Sat, 8 Sep 2001 02:17:28 -0400
Message-ID: <003001c1382d$f483d9d0$010da8c0@uglypunk>
From: "Kingsley Foreman" <kingsley@wintronics.com.au>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <3B99A8C2.56E88CE3@isn.net>
Subject: Re: 2.4.10-pre5
Date: Sat, 8 Sep 2001 15:44:31 +0930
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

Yes i got this too
anyone got a fix


----- Original Message -----
From: "Garst R. Reese" <reese@isn.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: <torvalds@transmeta.com>
Sent: Saturday, September 08, 2001 2:42 PM
Subject: 2.4.10-pre5


> gcc-3.0
> log should be self explanatory.
> cc me if rqd.
> Garst


----------------------------------------------------------------------------
----


> make[2]: Entering directory `/usr/src/linux/drivers/block'
>
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-tri
graphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpre
ferred-stack-boundary=2 -march=i586 -DMODULE   -c -o rd.o rd.c
> rd.c: In function `rd_ioctl':
> rd.c:262: invalid type argument of `->'
> rd.c: In function `rd_cleanup':
> rd.c:375: too few arguments to function `blkdev_put'
> make[2]: *** [rd.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/drivers/block'
> make[1]: *** [_modsubdir_block] Error 2
> make[1]: Leaving directory `/usr/src/linux/drivers'
> make: *** [_mod_drivers] Error 2
> Command exited with non-zero status 2
> 4.13user 0.37system 0:04.50elapsed 99%CPU (0avgtext+0avgdata
0maxresident)k
> 0inputs+0outputs (3849major+4162minor)pagefaults 0swaps
>

