Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274248AbRJJCXV>; Tue, 9 Oct 2001 22:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274244AbRJJCXP>; Tue, 9 Oct 2001 22:23:15 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:32334 "EHLO
	c0mailgw05.prontomail.com") by vger.kernel.org with ESMTP
	id <S274234AbRJJCXC>; Tue, 9 Oct 2001 22:23:02 -0400
Message-ID: <3BC3B110.1801FBAD@starband.net>
Date: Tue, 09 Oct 2001 22:23:12 -0400
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AIC7XXX Question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What exactly (besides commenting out that line) do I need to do to fix
this problem?

gcc -D__KERNEL__ -I/usr/src/linux-2.4.11/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o aic7xxx_old.o aic7xxx_old.c
aic7xxx_old.c:11966: parse error before string constant
aic7xxx_old.c:11966: warning: type defaults to `int' in declaration of
`MODULE_LICENSE'
aic7xxx_old.c:11966: warning: function declaration isn't a prototype
aic7xxx_old.c:11966: warning: data definition has no type or storage
class
make[3]: *** [aic7xxx_old.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.11/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.11/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.11/drivers'
make: *** [_dir_drivers] Error 2
[root@war linux]#



