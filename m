Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277097AbRJLADH>; Thu, 11 Oct 2001 20:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277104AbRJLAC5>; Thu, 11 Oct 2001 20:02:57 -0400
Received: from c1765315-a.mckiny1.tx.home.com ([65.10.75.71]:260 "EHLO
	aruba.maner.org") by vger.kernel.org with ESMTP id <S277097AbRJLACu> convert rfc822-to-8bit;
	Thu, 11 Oct 2001 20:02:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Compile of 2.4.10-ac12 dies on sparc64
Date: Thu, 11 Oct 2001 19:03:22 -0500
content-class: urn:content-classes:message
Message-ID: <C033B4C3E96AF74A89582654DEC664DB5559@aruba.maner.org>
Thread-Topic: Compile of 2.4.10-ac12 dies on sparc64
Thread-Index: AcFSsTpMc/5RBZu3Qd2wJi7DW2TTYg==
From: "Donald Maner" <donjr@maner.org>
To: "Linux Kernel (E-mail)" <linux-kernel@vger.rutgers.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile 2.4.10-ac12 on an Ultra10:

sparc64-linux-gcc -D__KERNEL__ -I/home/donjr/linux-2.4.10-ac12/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc
-mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7
-Wno-sign-compare -Wa,--undeclared-regs    -c -o init_task.o init_task.c
init_task.c:7: `INIT_MMAP' undeclared here (not in a function)
make[1]: *** [init_task.o] Error 1
make[1]: Leaving directory
`/home/donjr/linux-2.4.10-ac12/arch/sparc64/kernel'
make: *** [_dir_arch/sparc64/kernel] Error 2

Thanks
Donald

