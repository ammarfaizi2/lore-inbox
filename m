Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbSBUWel>; Thu, 21 Feb 2002 17:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbSBUWeb>; Thu, 21 Feb 2002 17:34:31 -0500
Received: from fcaglp.fcaglp.unlp.edu.ar ([163.10.4.1]:52116 "EHLO
	fcaglp.fcaglp.unlp.edu.ar") by vger.kernel.org with ESMTP
	id <S284732AbSBUWeR>; Thu, 21 Feb 2002 17:34:17 -0500
Message-ID: <3C7575DD.A460C1B9@fcaglp.fcaglp.unlp.edu.ar>
Date: Thu, 21 Feb 2002 19:34:05 -0300
From: "Eduardo A. Suarez" <esuarez@fcaglp.fcaglp.unlp.edu.ar>
Organization: Observatorio Astronomico de La Plata
X-Mailer: Mozilla 4.7 [en] (X11; I; SunOS 5.8 sun4m)
X-Accept-Language: Spanish/Argentina, es-AR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.18-rc2-ac2 compile error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/linux-2.4.18-rc2-ac2/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7  
-DKBUILD_BASENAME=binfmt_elf  -c -o binfmt_elf.o binfmt_elf.c
binfmt_elf.c: In function `elf_core_dump':
binfmt_elf.c:1062: parse error before `down_write'
make[2]: *** [binfmt_elf.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.18-rc2-ac2/fs'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.18-rc2-ac2/fs'
make: *** [_dir_fs] Error 2

gcc-2.95.2/binutils-2.11.2

Sparcstation10 running 2.4.18-rc2.

Thanks.
