Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSFUMnK>; Fri, 21 Jun 2002 08:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSFUMnJ>; Fri, 21 Jun 2002 08:43:09 -0400
Received: from static62-99-146-174.adsl.inode.at ([62.99.146.174]:14752 "EHLO
	silo.pitzeier.priv.at") by vger.kernel.org with ESMTP
	id <S316579AbSFUMnJ>; Fri, 21 Jun 2002 08:43:09 -0400
From: "Oliver Pitzeier" <oliver@linux-kernel.at>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.24 on alpha; fls redefined!? HELP NEEDED
Date: Fri, 21 Jun 2002 14:42:57 +0200
Organization: Linux Kernel Austria
Message-ID: <000501c21921$2ead26f0$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020621064835.GA13502@alpha.of.nowhere>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Where comes this from and _why_???

/usr/src/linux-2.5.24/include/asm/bitops.h:471:1: warning: "fls"
redefined
 
^^^^^^^^^^^^^^^^^^^^^^^^
/usr/src/linux-2.5.24/include/asm/bitops.h:329:1: warning: this is the
location of the previous definition
  gcc -Wp,-MD,./.capability.o.d -D__KERNEL__
-I/usr/src/linux-2.5.24/include -Wall -Wstrict-prototypes -Wno-trigraphs
-O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
-mno-fp-regs -ffixed-8 -msmall-data -mcpu=ev5 -Wa,-mev6 -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=capability   -c -o
capability.o capability.c
In file included from /usr/src/linux-2.5.24/include/linux/bitops.h:3,
                 from
/usr/src/linux-2.5.24/include/linux/thread_info.h:10,
                 from /usr/src/linux-2.5.24/include/linux/spinlock.h:7,
                 from
/usr/src/linux-2.5.24/include/linux/capability.h:44,
                 from /usr/src/linux-2.5.24/include/linux/sched.h:9,
                 from /usr/src/linux-2.5.24/include/linux/mm.h:4,
                 from capability.c:10:

I get this error very often... I guess in all files in
include/asm-alpha/ ...

-Oliver


