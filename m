Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269717AbSISBQt>; Wed, 18 Sep 2002 21:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269720AbSISBQt>; Wed, 18 Sep 2002 21:16:49 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:49905
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269717AbSISBQt>; Wed, 18 Sep 2002 21:16:49 -0400
Subject: Re: 2.4.20-pre7-ac2 compile and IrDA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3bs6uyerj.fsf_-_@lapper.ihatent.com>
References: <200209190222.33276.duncan.sands@math.u-psud.fr>
	<3D891BD1.8F774946@digeo.com>  <m3bs6uyerj.fsf_-_@lapper.ihatent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 02:25:56 +0100
Message-Id: <1032398756.24835.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 02:00, Alexander Hoogerhuis wrote:
> 2.4.20-pre7-ac2 has a problem compiling the irtty module:
> 
> make[3]: Entering directory `/home/alexh/src/linux/linux-2.4-ac-test/drivers/net/irda'
> gcc -D__KERNEL__ -I/home/alexh/src/linux/linux-2.4-ac-test/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/alexh/src/linux/linux-2.4-ac-test/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=irtty  -c -o irtty.o irtty.c
> irtty.c: In function `irtty_set_dtr_rts':
> irtty.c:761: `TIOCM_MODEM_BITS' undeclared (first use in this function)
> irtty.c:761: (Each undeclared identifier is reported only once
> irtty.c:761: for each function it appears in.)
>

What architecture - its defined for x86 definitely

