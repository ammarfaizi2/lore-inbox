Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311194AbSCLNcb>; Tue, 12 Mar 2002 08:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311188AbSCLNcW>; Tue, 12 Mar 2002 08:32:22 -0500
Received: from tiamat.Belgium.EU.net ([193.74.210.155]:35231 "EHLO
	tiamat.Belgium.EU.net") by vger.kernel.org with ESMTP
	id <S311185AbSCLNcG>; Tue, 12 Mar 2002 08:32:06 -0500
Message-ID: <3C8E0337.CEAD18BB@pophost.eunet.be>
Date: Tue, 12 Mar 2002 14:31:35 +0100
From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> Here goes -pre3, with the new IDE code. It has been stable enough time in
> the -ac tree, in my and Alan's opinion.
> 
> The inclusion of the new IDE code makes me want to have a longer 2.4.19
> release cycle, for stress-testing reasons.
> 
> Please stress test it with huge amounts of data ;)

make[3]: Entering directory `/usr/src/linux2419pre3/drivers/ide'
sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux2419pre3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fo
mit-frame-pointer -fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu
-mcpu=ultrasparc -mcmodel=medlow -ffixed-
g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare
-Wa,--undeclared-regs   -DKBUILD_BASENAME=ide  -DEXPORT_SYMTA
B -c ide.c
In file included from /usr/src/linux2419pre3/include/linux/ide.h:301,
                 from ide.c:149:
/usr/src/linux2419pre3/include/asm/ide.h:132: warning: `/*' within
comment
In file included from /usr/src/linux2419pre3/include/linux/ide.h:301,
                 from ide.c:149:
/usr/src/linux2419pre3/include/asm/ide.h:153: parse error before
`static'
/usr/src/linux2419pre3/include/asm/ide.h:153: warning: no semicolon at
end of struct or union
/usr/src/linux2419pre3/include/asm/ide.h:153: warning: no semicolon at
end of struct or union
/usr/src/linux2419pre3/include/asm/ide.h: In function `ide_insw':
/usr/src/linux2419pre3/include/asm/ide.h:175: warning: implicit
declaration of function `inw_be'
/usr/src/linux2419pre3/include/asm/ide.h: At top level:
/usr/src/linux2419pre3/include/asm/ide.h:320: warning: This file
contains more `{'s than `}'s.
/usr/src/linux2419pre3/include/linux/ide.h:1103: warning: This file
contains more `{'s than `}'s.
ide.c: In function `ide_dump_status':
ide.c:993: warning: long long int format, long int arg (arg 2)
ide.c: In function `hwif_unregister':
ide.c:2188: warning: implicit declaration of function
`ide_release_region'
make[3]: *** [ide.o] Error 1
make[3]: Leaving directory `/usr/src/linux2419pre3/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux2419pre3/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux2419pre3/drivers'
make: *** [_dir_drivers] Error 2



Jurgen.
