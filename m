Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264847AbSKENKi>; Tue, 5 Nov 2002 08:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264850AbSKENKi>; Tue, 5 Nov 2002 08:10:38 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:148 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264847AbSKENKi>; Tue, 5 Nov 2002 08:10:38 -0500
Message-Id: <4.3.2.7.2.20021105142212.00c611d0@192.168.6.2>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 05 Nov 2002 14:22:42 +0100
To: linux-kernel@vger.kernel.org
From: Roger While <RogerWhile@sim-basis.de>
Subject: 2.5.46 make modules fail
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-MDRemoteIP: 192.168.6.50
X-Return-Path: RogerWhile@sim-basis.de
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -Wp,-MD,net/ipv4/netfilter/.ipt_TCPMSS.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include 
-DMODULE   -DKBUILD_BASENAME=ipt_TCPMSS   -c -o 
net/ipv4/netfilter/ipt_TCPMSS.o net/ipv4/netfilter/ipt_TCPMSS.c
net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
net/ipv4/netfilter/ipt_TCPMSS.c:88: structure has no member named `pmtu'
net/ipv4/netfilter/ipt_TCPMSS.c:91: structure has no member named `pmtu'
net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'
make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
make[2]: *** [net/ipv4/netfilter] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2


