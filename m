Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264845AbSKENFu>; Tue, 5 Nov 2002 08:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264847AbSKENFu>; Tue, 5 Nov 2002 08:05:50 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:64650 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264845AbSKENFt>; Tue, 5 Nov 2002 08:05:49 -0500
Message-Id: <4.3.2.7.2.20021105141812.00c5ccd0@192.168.6.2>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 05 Nov 2002 14:18:35 +0100
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

   gcc -Wp,-MD,net/bridge/.br_netfilter.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include 
-DMODULE   -DKBUILD_BASENAME=br_netfilter   -c -o net/bridge/br_netfilter.o 
net/bridge/br_netfilter.c
net/bridge/br_netfilter.c:60: unknown field `pmtu' specified in initializer
net/bridge/br_netfilter.c: In function `br_nf_pre_routing_finish':
net/bridge/br_netfilter.c:162: warning: implicit declaration of function 
`ip_route_output'
make[2]: *** [net/bridge/br_netfilter.o] Error 1
make[1]: *** [net/bridge] Error 2
make: *** [net] Error 2


