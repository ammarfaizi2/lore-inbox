Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287090AbRL2CZt>; Fri, 28 Dec 2001 21:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287096AbRL2CZa>; Fri, 28 Dec 2001 21:25:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23556 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287090AbRL2CZU>; Fri, 28 Dec 2001 21:25:20 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: zImage not supported for 2.2.20?
Date: 28 Dec 2001 18:25:06 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a0j9i2$tkr$1@cesium.transmeta.com>
In-Reply-To: <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1> <E16K1bW-0001K0-00@the-village.bc.nu> <20011228223604.A370@elektroni.ee.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011228223604.A370@elektroni.ee.tut.fi>
By author:    Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
In newsgroup: linux.dev.kernel
> 
> Hi, I was one that reported the problem that zImage doesn't work. I don't
> personally care whether it works or not because bzImages are fine for my
> machines. Anyway, 2.2.20pre3 was ok but 2.2.20pre5 was not. I just rechecked
> with 2.2.20 final. I compiled 2.2.20 'make zImage; make bzImage' for one old
> 486 and for one pentium. Both print Out of memory and System halted for the
> zImages and work fine with bzImages.
> 
> 486:
> 
> Memory: 47176k/49152k available (796k kernel code, 408k reserved, 728k data, 44k init)
>    text    data     bss     dec     hex filename
>  853655   90740  125288 1069683  105273 vmlinux
> -rwxr-xr-x    1 kaukasoi users     1111776 Dec 28 21:46 vmlinux
> -rw-r--r--    1 kaukasoi users      458880 Dec 28 21:46 bzImage
> -rw-r--r--    1 kaukasoi users      458877 Dec 28 21:46 zImage
> 
> pentium:
> 
> Memory: 63516k/65536k available (736k kernel code, 416k reserved, 828k data, 40k init)
>    text    data     bss     dec     hex filename
>  788441   90140  105768  984349   f051d vmlinux
> -rwxr-xr-x    1 kaukasoi users     1098107 Dec 28 22:04 vmlinux
> -rw-r--r--    1 kaukasoi users      442277 Dec 28 22:04 bzImage
> -rw-r--r--    1 kaukasoi users      442277 Dec 28 22:04 zImage
> 
> I compiled them with gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2
> release) and binutils 2.11.90.0.19 (tehy are the versions that come with
> Slackware 8.0). The pentium uses LILO version 19 and the 486 uses version
> 21.7-5.
> 
> If you think those are too large kernels for zImage, e.g. this 2.2.19 works
> ok on the 486:
> -rw-r--r--    1 root     root       476269 Aug 11 23:32 zImage
> Memory: 47136k/49152k available (832k kernel code, 412k reserved, 728k data, 44k init)
> -

Machine/motherboard/chipset/BIOS info?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
