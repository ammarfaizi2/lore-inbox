Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279586AbRJXULI>; Wed, 24 Oct 2001 16:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279583AbRJXUK6>; Wed, 24 Oct 2001 16:10:58 -0400
Received: from zeus.penguinhosting.net ([206.152.182.152]:24803 "HELO
	mail.penguinhosting.net") by vger.kernel.org with SMTP
	id <S278632AbRJXUKo>; Wed, 24 Oct 2001 16:10:44 -0400
Date: Wed, 24 Oct 2001 20:11:11 +0000
From: Ian Gulliver <ian@penguinhosting.net>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.12-ac6 compile errors on sparc64
Message-ID: <20011024201110.A3536@penguinhosting.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux zeus.penguinhosting.net 2.4.6-pre3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to compile linux-2.4.12-ac6 on sparc64.
linux-2.4.13 compiles fine on the same machine.

anubis% sparc64-linux-gcc --version
3.0.2
anubis% make

..............

make[1]: Entering directory `/home/ian/linux-2.4.10-ac12/arch/sparc64/kernel'
sparc64-linux-gcc -D__KERNEL__ -I/home/ian/linux-2.4.10-ac12/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs    -c -o init_task.o init_task.c
init_task.c:7: `INIT_MMAP' undeclared here (not in a function)
make[1]: *** [init_task.o] Error 1
make[1]: Leaving directory `/home/ian/linux-2.4.10-ac12/arch/sparc64/kernel'
make: *** [_dir_arch/sparc64/kernel] Error 2
