Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRAXWYI>; Wed, 24 Jan 2001 17:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130030AbRAXWXs>; Wed, 24 Jan 2001 17:23:48 -0500
Received: from moon.aladdin.de ([212.14.90.34]:3338 "EHLO moon.aladdin.de")
	by vger.kernel.org with ESMTP id <S129855AbRAXWXj>;
	Wed, 24 Jan 2001 17:23:39 -0500
Subject: problem compiling 2.4.1-pre10 on ppc
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.1a (Intl) 17 August 1999
Message-ID: <OF73CDAD34.BF5BD856-ONC12569DE.007AA0BB@aladdin.de>
From: cpg@aladdin.de
Date: Wed, 24 Jan 2001 23:20:45 +0100
X-MIMETrack: Serialize by Router on Moon/MUC/AKS(Release 5.0.5 |September 22, 2000) at
 01/24/2001 11:24:26 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring    -c -o signal.o signal.c
signal.c:57: conflicting types for `sys_wait4'
/usr/src/linux/include/linux/sched.h:566: previous declaration of `sys_wait4'
make[1]: *** [signal.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.1-pre10/arch/ppc/kernel'

regards,
chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
