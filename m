Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131388AbQJ1Uih>; Sat, 28 Oct 2000 16:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131337AbQJ1Ui0>; Sat, 28 Oct 2000 16:38:26 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:6660 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S131333AbQJ1UiS>;
	Sat, 28 Oct 2000 16:38:18 -0400
Message-Id: <200010281456.e9SEue007566@sleipnir.valparaiso.cl>
To: Jens Maurer <jmaurer@cck.uni-kl.de>
Cc: linux-kernel@vger.kernel.org
Subject: linux-2.4.0-test10-pre6: Trigraphs in drivers/pci/devlist.h
X-Mailer: MH [Version 6.8.4]
Date: Sat, 28 Oct 2000 11:56:40 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I understand you are in charge of this per MAINTAINERS, it not, I
apologize for bothering you.

Red Hat 7, i686, gcc-20001027 (from CVS) complains about '??)' trigraphs at
lines 1278 and 6367. Should that be just '(?)', or perhaps 'xx'? (egcs-1.1.2
keeps quiet).

[Yes, trigraphs are bletcherous. Perhaps disable the warning for good in
 Makefile:

 HOSTCFLAGS      = -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
]
Thanks!
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                              +56 32 672616

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
