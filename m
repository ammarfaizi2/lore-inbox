Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264855AbSKENPb>; Tue, 5 Nov 2002 08:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbSKENPb>; Tue, 5 Nov 2002 08:15:31 -0500
Received: from fe4.rdc-kc.rr.com ([24.94.163.51]:49158 "EHLO mail4.kc.rr.com")
	by vger.kernel.org with ESMTP id <S264855AbSKENPa>;
	Tue, 5 Nov 2002 08:15:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: dark side <ognen@kc.rr.com>
To: Roger While <RogerWhile@sim-basis.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46 make modules fail
Date: Tue, 5 Nov 2002 07:22:40 -0600
X-Mailer: KMail [version 1.3.2]
References: <4.3.2.7.2.20021105142212.00c611d0@192.168.6.2>
In-Reply-To: <4.3.2.7.2.20021105142212.00c611d0@192.168.6.2>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <0873157171305b2FE4@mail4.kc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a fix posted several times for this. It applied to 2.5.45 but it 
should also apply to 2.5.46. Look in the archives.

Cheers,
Ognen

On Tuesday 05 November 2002 07:22 am, Roger While wrote:
> gcc -Wp,-MD,net/ipv4/netfilter/.ipt_TCPMSS.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
> -DMODULE   -DKBUILD_BASENAME=ipt_TCPMSS   -c -o
> net/ipv4/netfilter/ipt_TCPMSS.o net/ipv4/netfilter/ipt_TCPMSS.c
> net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
> net/ipv4/netfilter/ipt_TCPMSS.c:88: structure has no member named `pmtu'
> net/ipv4/netfilter/ipt_TCPMSS.c:91: structure has no member named `pmtu'
> net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'
> make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
> make[2]: *** [net/ipv4/netfilter] Error 2
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2
