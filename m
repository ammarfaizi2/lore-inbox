Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131806AbQKUX5i>; Tue, 21 Nov 2000 18:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131828AbQKUX52>; Tue, 21 Nov 2000 18:57:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64082 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131806AbQKUX5P>; Tue, 21 Nov 2000 18:57:15 -0500
Subject: Re: Linux 2.4.0test11-ac1
To: scole@lanl.gov
Date: Tue, 21 Nov 2000 23:27:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00112112071001.00924@spc.esa.lanl.gov> from "Steven Cole" at Nov 21, 2000 12:07:10 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yMpH-0005LI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried to compile 2.4.0-test11-ac1, and here is where the compile bombed out:
> 
> /usr/bin/kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
> -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686    -c -o 
> sched.o sched.c
> irq.c:182: conflicting types for `global_irq_lock'
> /usr/src/linux/include/asm/hardirq.h:45: previous declaration of 
> `global_irq_lock'

I'll check this. I take it you tried an SMP build ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
