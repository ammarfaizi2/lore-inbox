Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261621AbSJNN1H>; Mon, 14 Oct 2002 09:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261622AbSJNN1G>; Mon, 14 Oct 2002 09:27:06 -0400
Received: from ligur.expressz.com ([212.24.178.154]:58301 "EHLO expressz.com")
	by vger.kernel.org with ESMTP id <S261621AbSJNN1E>;
	Mon, 14 Oct 2002 09:27:04 -0400
Date: Mon, 14 Oct 2002 15:32:53 +0200 (CEST)
From: "BODA Karoly jr." <woockie@expressz.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.42-ac1 serial compile error on sparc
Message-ID: <Pine.LNX.3.96.1021014152950.28326A-100000@ligur.expressz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

	The serial.h is missing for the sparc architecture:

  sparc64-linux-gcc -Wp,-MD,drivers/serial/.8250.o.d -D__KERNEL__
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc
-mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare
-Wa,--undeclared-regs -pg -nostdinc -iwithprefix include
-DKBUILD_BASENAME=8250 -DEXPORT_SYMTAB  -c -o drivers/serial/8250.o
drivers/serial/8250.c
drivers/serial/8250.c:104: asm/serial.h: No such file or directory

-- 
						Woockie
..."what is there in this world that makes living worthwhile?"
Death thought about it. "CATS," he said eventually, "CATS ARE NICE."
			           (Terry Pratchett, Sourcery)

