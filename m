Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSJPXA6>; Wed, 16 Oct 2002 19:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbSJPXA6>; Wed, 16 Oct 2002 19:00:58 -0400
Received: from smtp06.iddeo.es ([62.81.186.16]:8590 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S261427AbSJPXA5>;
	Wed, 16 Oct 2002 19:00:57 -0400
Date: Thu, 17 Oct 2002 01:06:49 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1 Compile Error
Message-ID: <20021016230649.GE1616@werewolf.able.es>
References: <20021016214835.GA6510@mail-infomine.ucr.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021016214835.GA6510@mail-infomine.ucr.edu>; from ruschein@mail-infomine.ucr.edu on Wed, Oct 16, 2002 at 23:48:35 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


On 2002.10.16 Johannes Ruscheinski wrote:
>make[1]: Entering directory `/usr/src/kernel/linux-2.4.20pre11aa1/arch/i386/kernel'
>gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.4.20pre11aa1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -iwithprefix include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
>mpparse.c:70: `dest_LowestPrio' undeclared here (not in a function)
>make[1]: *** [mpparse.o] Error 1
>make[1]: Leaving directory `/usr/src/kernel/linux-2.4.20pre11aa1/arch/i386/kernel'
>
>.config upon request.

Known problem. Use attached patch.


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre11-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))

--YZ5djTAD1cGYuMQK
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="02-up-apic.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWUlTOQ4AATHfgCAwSH//+v/v/+C/79/iUANb2bAAAA0kyjJ6g0NGQYjTQAAA
GhoA0BxkyaaYTIyBgRiaMEYQaNMAAg01FNHqGgaAAAAAAAAAAcZMmmmEyMgYEYmjBGEGjTAA
IJIhNNE0YptTaSGKaeSD0mNGpo0/UJ6T09J6RqSwjzWNQ3EFg/UXKCiIXh8tqqti1OLY07WX
ZaKm96mP5aVVxL1CEKrqligdgLJegJ3eLXsQ5j8sVYsFbllyMzJvZJJwlCsE8+hJdTAQkcLS
g0YTAoB0VB4iWKOgOA4HnxGFMniVibpBKSQVEBc9lidDoYPwblrmoAzTr565AOskoIokuktA
ppbpN3l+qbHBaD4hCiQhBQhChRSEPagzF6gMmUVwTkhZXMw2K8yU0vTx8vE1a9As4dCvEyZX
L2ScyZxeNgoK6XtPcS/ckg6/aOKpQdQIEhORiLPbV4IGtFSMo6BglWya41GtBXXQ7IiwVVdC
SDeLQ8ok+EVguepoKHw+/Ifm7dJ1i2JhkwmGEy86952CgoLwPej6ji55Dn0H7UHcDoHRu+ZE
KksSIwf9YOd5wHRvAsomFvs7xOmRu7xbC/rZpTCETWYq0xKi5kSJDrgMDmkmKLhEasNYMrSs
TxC0VEjhMq/lZSMjUUY1lmkgi0gMXgywTl+ovsMKlIWkuIkxi4gF6u84tEVDBU8BpmewUg5V
2Hxgg7j4P0QN5Ed2bvPrMoepzYFZ8h1Jj4h8zmYbT1KcVD1kVuFuQYCrC0+i6iFxziySC0Jg
a0x3G8CusKOOFgMUFmEDLtZoCgJiCZD4renAdXlBSEPETotFOoNom/CJ1niq0vtGKyDSYjjg
XKUYRA415BHQtocgu1XwFdjqDiHAmX5gcdCkUZsmbFTT5Fpo5XF+LUYaWoLy5C8TN0Q8sNJE
milFUYsIdWK9ZqsGQXgQE+1mbzAMkSYVBrDmEXDmi9UVnUsDYqKgQFfBUwUQiawcWonX6Y+p
Y1AVNFYDo0+zap9KqNZUpxzAoGatkCahQwFNY2GS4hFJIKQrExyDaGtjYV9K1l6s5u52dzyS
karEWFSgtyLVhNg0BnP/xdyRThQkElTOQ4A=

--YZ5djTAD1cGYuMQK--
