Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265692AbSKASsa>; Fri, 1 Nov 2002 13:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265699AbSKASsa>; Fri, 1 Nov 2002 13:48:30 -0500
Received: from technicolor.pl ([62.21.19.63]:47890 "EHLO wilnet.info")
	by vger.kernel.org with ESMTP id <S265692AbSKASs3>;
	Fri, 1 Nov 2002 13:48:29 -0500
Date: Fri, 1 Nov 2002 19:54:54 +0100 (CET)
From: Pawel Bernadowski <pbern@wilnet.info>
To: linux-kernel@vger.kernel.org
Subject: 2.5.45 (vanilla & mcp1)  build error
Message-ID: <Pine.LNX.4.44L.0211011948160.7070-100000@farma.wilnet.info>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on both version ( linux-2.5.45 and linux-2.5.45-mcp1):
i have this problem:

  gcc -Wp,-MD,net/ipv4/.ipmr.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=ipmr   -c -o net/ipv4/ipmr.o net/ipv4/ipmr.c
net/ipv4/ipmr.c: In function `ipmr_forward_finish':
net/ipv4/ipmr.c:1114: structure has no member named `pmtu'
net/ipv4/ipmr.c: In function `ipmr_queue_xmit':
net/ipv4/ipmr.c:1170: structure has no member named `pmtu'
net/ipv4/ipmr.c: At top level:
net/ipv4/ipmr.c:111: warning: `pim_protocol' defined but not used
make[2]: *** [net/ipv4/ipmr.o] Error 1
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.3879 (%build)


Pawel Bernadowski
GG: 3377

