Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310186AbSB1XPE>; Thu, 28 Feb 2002 18:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310185AbSB1XNQ>; Thu, 28 Feb 2002 18:13:16 -0500
Received: from clem.digital.net ([216.230.43.233]:14 "EHLO clem.digital.net")
	by vger.kernel.org with ESMTP id <S310195AbSB1XLv>;
	Thu, 28 Feb 2002 18:11:51 -0500
From: Pete Clements <clem@clem.digital.net>
Message-Id: <200202282311.SAA04406@clem.digital.net>
Subject: 2.5.6-pre2 fails compile [ide.c]
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Thu, 28 Feb 2002 18:11:47 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

gcc -D__KERNEL__ -I/sda3/usr/src/linux-2.5.6/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=ide  -DEXPORT_SYMTAB -c ide.c
ide.c:161: parse error before `ide_pio_timings'
ide.c:161: warning: type defaults to `int' in declaration of `ide_pio_timings'
ide.c:162: warning: braces around scalar initializer
ide.c:162: warning: (near initialization for `ide_pio_timings[0]')
ide.c:162: warning: excess elements in scalar initializer
ide.c:162: warning: (near initialization for `ide_pio_timings[0]')
ide.c:162: warning: excess elements in scalar initializer
ide.c:162: warning: (near initialization for `ide_pio_timings[0]')
ide.c:163: warning: braces around scalar initializer
ide.c:163: warning: (near initialization for `ide_pio_timings[1]')
ide.c:163: warning: excess elements in scalar initializer
ide.c:163: warning: (near initialization for `ide_pio_timings[1]')
ide.c:163: warning: excess elements in scalar initializer
ide.c:163: warning: (near initialization for `ide_pio_timings[1]')
ide.c:164: warning: braces around scalar initializer
ide.c:164: warning: (near initialization for `ide_pio_timings[2]')
ide.c:164: warning: excess elements in scalar initializer
ide.c:164: warning: (near initialization for `ide_pio_timings[2]')
ide.c:164: warning: excess elements in scalar initializer
ide.c:164: warning: (near initialization for `ide_pio_timings[2]')
ide.c:165: warning: braces around scalar initializer
ide.c:165: warning: (near initialization for `ide_pio_timings[3]')
ide.c:165: warning: excess elements in scalar initializer
ide.c:165: warning: (near initialization for `ide_pio_timings[3]')
ide.c:165: warning: excess elements in scalar initializer
ide.c:165: warning: (near initialization for `ide_pio_timings[3]')
ide.c:166: warning: braces around scalar initializer
ide.c:166: warning: (near initialization for `ide_pio_timings[4]')
ide.c:166: warning: excess elements in scalar initializer
ide.c:166: warning: (near initialization for `ide_pio_timings[4]')
ide.c:166: warning: excess elements in scalar initializer
ide.c:166: warning: (near initialization for `ide_pio_timings[4]')
ide.c:167: warning: braces around scalar initializer
ide.c:167: warning: (near initialization for `ide_pio_timings[5]')
ide.c:167: warning: excess elements in scalar initializer
ide.c:167: warning: (near initialization for `ide_pio_timings[5]')
ide.c:167: warning: excess elements in scalar initializer
ide.c:167: warning: (near initialization for `ide_pio_timings[5]')
ide.c:168: warning: data definition has no type or storage class
ide.c:307: parse error before `ide_pio_data_t'
ide.c:308: warning: function declaration isn't a prototype
ide.c: In function `ide_get_best_pio_mode':
ide.c:312: `drive' undeclared (first use in this function)
ide.c:312: (Each undeclared identifier is reported only once
ide.c:312: for each function it appears in.)
ide.c:316: `mode_wanted' undeclared (first use in this function)
ide.c:361: request for member `cycle_time' in something not a structure or union
ide.c:365: `max_mode' undeclared (first use in this function)
ide.c:369: `d' undeclared (first use in this function)
ide.c:371: request for member `cycle_time' in something not a structure or union
ide.c:309: warning: `pio_mode' might be used uninitialized in this function
make[3]: *** [ide.o] Error 1
make[3]: Leaving directory `/sda3/usr/src/linux-2.5.6/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/sda3/usr/src/linux-2.5.6/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/sda3/usr/src/linux-2.5.6/drivers'
make: *** [_dir_drivers] Error 2

-- 
Pete Clements 
clem@clem.digital.net
