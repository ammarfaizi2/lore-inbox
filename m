Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRADXXJ>; Thu, 4 Jan 2001 18:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRADXW7>; Thu, 4 Jan 2001 18:22:59 -0500
Received: from [62.81.160.68] ([62.81.160.68]:19652 "EHLO smtp2.alehop.com")
	by vger.kernel.org with ESMTP id <S129348AbRADXWr>;
	Thu, 4 Jan 2001 18:22:47 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
From: "Ignacio Monge" <ignaciomonge@navegalia.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.0-prerelease-ac6 compile errors
X-Mailer: Pronto v2.2.2 On linux
Date: 05 Jan 2001 00:17:57 CET
Reply-To: "Ignacio Monge" <ignaciomonge@navegalia.com>
Message-Id: <20010104232253Z129348-400+400@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Problem: compile error in linux-2.4.0-prerelease-ac6

System:
	Intel Pentium II 233 Mhz 96 Mb RAM
	Red Hat Linux System 7.0
	Glibc-2.2-5
	Gcc-2.95.2-12

Output error:
[...]

ld -m elf_i386	-r -o drm.o tdfx.o drmlib.a
make[4]: Saliendo directorio `/usr/src/linux/drivers/char/drm'
make[3]: Saliendo directorio `/usr/src/linux/drivers/char/drm'
make all_targets
make[3]: Cambiando a directorio `/usr/src/linux/drivers/char'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i686    -DEXPORT_SYMTAB -c serial.c
serial.c: In function `probe_serial_pnp':
serial.c:5187: structure has no member named `device'
serial.c:5192: structure has no member named `device'
make[3]: *** [serial.o] Error 1
make[3]: Saliendo directorio `/usr/src/linux/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Saliendo directorio `/usr/src/linux/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Saliendo directorio `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
