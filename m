Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbRGDNsM>; Wed, 4 Jul 2001 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264710AbRGDNsC>; Wed, 4 Jul 2001 09:48:02 -0400
Received: from cibs9.sns.it ([192.167.206.29]:27908 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S264697AbRGDNr5>;
	Wed, 4 Jul 2001 09:47:57 -0400
Date: Wed, 4 Jul 2001 15:47:51 +0200
From: V man <venom@DarkStar.sns.it>
Message-Id: <200107041347.PAA01400@cibs9.sns.it>
To: marc@mbsi.ca
Subject: problems with netfilter 2.4.6 with mark unclean.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
upgrading to new linux kernel
2.4.6, with FULL netfilter enabled and
compiled statically inside of the kernel, 
a rule like

iptables -A INPUT -m unclean -j DROP

will put netfilter in condition to DROP
every tcp packet it receives.
That is not true with UDP or icmp,
(NFS and all icmp work)
but the kernel will DROP ALL tcp apckets.

That was not happening with 2.4.5 kernel and older, so that
i was able to use this rule against malformed packets.

I tried bot compiling kernel with egcs, gcc 2.95.3 and gcc 3.0.

System is
PentiumIII 550 Mhz
128 Mbyte Ram
1 IDE disk 33Mhz
intel MB vx 440

binutils 2.11.90.0.19
glibc 2.2.3

Bests
Luigi Genoni
