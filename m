Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSKABWB>; Thu, 31 Oct 2002 20:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265566AbSKABVj>; Thu, 31 Oct 2002 20:21:39 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:21234 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265569AbSKABUw> convert rfc822-to-8bit; Thu, 31 Oct 2002 20:20:52 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Skip Ford <skip.ford@verizon.net>
Subject: 2.5.45 ipt_TCPMSS.c syntax error
Date: Fri, 1 Nov 2002 02:27:14 +0100
User-Agent: KMail/1.4.7
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200211010227.14140.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f scripts/Makefile.build obj=sound/core/seq/oss
  gcc -Wp,-MD,net/ipv4/netfilter/.ipt_TCPMSS.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -mcpu=k6 
-march=i686 -malign-functions=4 -fschedule-insns2 -fexpensive-optimizations 
-Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE -include 
include/linux/modversions.h   -DKBUILD_BASENAME=ipt_TCPMSS   -c -o 
net/ipv4/netfilter/ipt_TCPMSS.o net/ipv4/netfilter/ipt_TCPMSS.c
net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
net/ipv4/netfilter/ipt_TCPMSS.c:88: structure has no member named `pmtu'
net/ipv4/netfilter/ipt_TCPMSS.c:91: structure has no member named `pmtu'
net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'
make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
make[2]: *** [net/ipv4/netfilter] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

On x86 (Athlon)

-Dieter
