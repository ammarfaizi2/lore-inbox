Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261954AbSIYKuz>; Wed, 25 Sep 2002 06:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbSIYKuz>; Wed, 25 Sep 2002 06:50:55 -0400
Received: from adambe1.lnk.telstra.net ([139.130.12.177]:25216 "HELO unibar")
	by vger.kernel.org with SMTP id <S261954AbSIYKuz>;
	Wed, 25 Sep 2002 06:50:55 -0400
Message-ID: <20020925105604.2777.qmail@unibar>
From: adam@skullslayer.rod.org
Subject: UML compile error
To: linux-kernel@vger.kernel.org
Date: Wed, 25 Sep 2002 20:56:04 +1000 (EST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to test UML, and tried 2.5.36 through to 38, but have been
unable to comile it. I tried using the default config, as well as
my own config, but both 37 and 38 give the following error.

  gcc -Wp,-MD,./.sched.o.d -D__KERNEL__ -I/usr/src/linux-2.5.38/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2  -fno-strict-aliasing -fno-common -g  -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE -I/usr/src/linux-2.5.38/arch/um/include -Derrno=kernel_errno -nostdinc -iwithprefix include    -fno-omit-frame-pointer -DKBUILD_BASENAME=sched   -c -o sched.o sched.c
In file included from /usr/src/linux-2.5.38/include/asm/irq.h:9,
                 from /usr/src/linux-2.5.38/include/linux/nmi.h:7,
                 from sched.c:20:
/usr/src/linux-2.5.38/include/asm/arch/irq.h:16:25: irq_vectors.h: No such file or directory
make[1]: *** [sched.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.38/kernel'
make: *** [kernel] Error 2

    Adam

