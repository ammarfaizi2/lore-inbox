Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269996AbSISG34>; Thu, 19 Sep 2002 02:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270001AbSISG34>; Thu, 19 Sep 2002 02:29:56 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:32210 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S269996AbSISG3z>;
	Thu, 19 Sep 2002 02:29:55 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre7-ac2 compile and IrDA
References: <200209190222.33276.duncan.sands@math.u-psud.fr>
	<3D891BD1.8F774946@digeo.com> <m3bs6uyerj.fsf_-_@lapper.ihatent.com>
	<1032398756.24835.29.camel@irongate.swansea.linux.org.uk>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 19 Sep 2002 08:34:54 +0200
In-Reply-To: <1032398756.24835.29.camel@irongate.swansea.linux.org.uk>
Message-ID: <m38z1ysd0x.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Thu, 2002-09-19 at 02:00, Alexander Hoogerhuis wrote:
> > 2.4.20-pre7-ac2 has a problem compiling the irtty module:
> > 
> > make[3]: Entering directory `/home/alexh/src/linux/linux-2.4-ac-test/drivers/net/irda'
> > gcc -D__KERNEL__ -I/home/alexh/src/linux/linux-2.4-ac-test/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/alexh/src/linux/linux-2.4-ac-test/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=irtty  -c -o irtty.o irtty.c
> > irtty.c: In function `irtty_set_dtr_rts':
> > irtty.c:761: `TIOCM_MODEM_BITS' undeclared (first use in this function)
> > irtty.c:761: (Each undeclared identifier is reported only once
> > irtty.c:761: for each function it appears in.)
> >
> 
> What architecture - its defined for x86 definitely

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz
stepping        : 4
cpu MHz         : 1196.146
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2385.51

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
