Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSCUQgw>; Thu, 21 Mar 2002 11:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312248AbSCUQgo>; Thu, 21 Mar 2002 11:36:44 -0500
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:31137 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S311871AbSCUQfi>;
	Thu, 21 Mar 2002 11:35:38 -0500
Date: Thu, 21 Mar 2002 19:34:53 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: 2.5.7 does not compile
Message-Id: <20020321193453.0fe5c3ba.johnpol@2ka.mipt.ru>
In-Reply-To: <3C9A0735.8999EBB3@wanadoo.fr>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__21_Mar_2002_19:34:53_+0300_08262b48"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Thu__21_Mar_2002_19:34:53_+0300_08262b48
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2002 17:15:49 +0100
Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr> wrote:

> make[3]: Entering directory
> `/usr/src/kernel-sources-2.5.7/drivers/net/hamradio'
> gcc -D__KERNEL__ -I/usr/src/kernel-sources-2.5.7/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=k6 -DMODULE -DMODVERSIONS -include
> /usr/src/kernel-sources-2.5.7/include/linux/modversions.h 
> -DKBUILD_BASENAME=scc  -c -o scc.o scc.c
> scc.c: In function `scc_net_rx':
> scc.c:1664: `dev' undeclared (first use in this function)
> scc.c:1664: (Each undeclared identifier is reported only once
> scc.c:1664: for each function it appears in.)
> make[3]: *** [scc.o] Error 1
> make[3]: Leaving directory
> `/usr/src/kernel-sources-2.5.7/drivers/net/hamradio'
> make[2]: *** [_modsubdir_net/hamradio] Error 2
> make[2]: Leaving directory `/usr/src/kernel-sources-2.5.7/drivers'
> make[1]: *** [_mod_drivers] Error 2
> make[1]: Leaving directory `/usr/src/kernel-sources-2.5.7'
> make: *** [stamp-build] Error 2

I hope this path will help you.

> -----------
> Regards
> 	Jean-Luc

	Evgeniy Polyakov ( s0mbre )

--Multipart_Thu__21_Mar_2002_19:34:53_+0300_08262b48
Content-Type: application/octet-stream;
 name="drivers_net_hamradio_scc_c.diff"
Content-Disposition: attachment;
 filename="drivers_net_hamradio_scc_c.diff"
Content-Transfer-Encoding: base64

LS0tIC4vZHJpdmVycy9uZXQvaGFtcmFkaW8vc2NjLmN+CUZyaSBNYXIgIDggMjE6MTM6MjIgMjAw
MgorKysgLi9kcml2ZXJzL25ldC9oYW1yYWRpby9zY2MuYwlUaHUgTWFyIDIxIDE5OjMyOjE4IDIw
MDIKQEAgLTE2NjEsNyArMTY2MSw3IEBACiAJc2tiLT5wa3RfdHlwZSA9IFBBQ0tFVF9IT1NUOwog
CQogCW5ldGlmX3J4KHNrYik7Ci0JZGV2LT5sYXN0X3J4ID0gamlmZmllczsKKwlzY2MtPmRldi0+
bGFzdF9yeCA9IGppZmZpZXM7CiAJcmV0dXJuOwogfQogCg==

--Multipart_Thu__21_Mar_2002_19:34:53_+0300_08262b48--
