Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276984AbRJKWF3>; Thu, 11 Oct 2001 18:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276987AbRJKWFT>; Thu, 11 Oct 2001 18:05:19 -0400
Received: from haneman.dialup.fu-berlin.de ([160.45.224.9]:20740 "EHLO
	haneman.dialup.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S276984AbRJKWFI>; Thu, 11 Oct 2001 18:05:08 -0400
Date: Thu, 11 Oct 2001 23:58:03 +0200 (MESZ)
From: Enver Haase <root@haneman.dialup.fu-berlin.de>
Reply-To: Enver Haase <ehaase@inf.fu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Linux-2.4.12 does not build.
Message-ID: <Pine.LNX.4.10.10110112356310.8242-100000@haneman.hacenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make[3]: Wechsel in das Verzeichnis Verzeichnis
»/usr/src/linux-2.4.12/drivers/parport«
gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6    -c -o ieee1284_ops.o
ieee1284_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
this function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
this function)
make[3]: *** [ieee1284_ops.o] Fehler 1
make[3]: Verlassen des Verzeichnisses Verzeichnis
»/usr/src/linux-2.4.12/drivers/parport«
make[2]: *** [first_rule] Fehler 2
make[2]: Verlassen des Verzeichnisses Verzeichnis
»/usr/src/linux-2.4.12/drivers/parport«
make[1]: *** [_subdir_parport] Fehler 2
make[1]: Verlassen des Verzeichnisses Verzeichnis
»/usr/src/linux-2.4.12/drivers«
make: *** [_dir_drivers] Fehler 2


Sorry for the localized error messages; but you do understand them.

Greetings,
Enver

