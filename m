Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291660AbSBTFas>; Wed, 20 Feb 2002 00:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291661AbSBTFaj>; Wed, 20 Feb 2002 00:30:39 -0500
Received: from smtp0.myexcel.com ([205.208.223.1]:50188 "EHLO
	mail2.myexcel.com") by vger.kernel.org with ESMTP
	id <S291660AbSBTFad>; Wed, 20 Feb 2002 00:30:33 -0500
Message-ID: <002901c1b9cf$a6423450$e4c6c440@Molybdenum>
From: "Jahn Veach" <V64@V64.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.5 Build Failure
Date: Tue, 19 Feb 2002 23:30:00 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[2]: Entering directory `/usr/src/linux-2.5/fs'
gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno
-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -
mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=filesystems  -DE
XPORT_SYMTAB -c filesystems.c
filesystems.c: In function `sys_nfsservctl':
filesystems.c:30: dereferencing pointer to incomplete type
filesystems.c:30: dereferencing pointer to incomplete type
filesystems.c:30: warning: value computed is not used
filesystems.c:32: dereferencing pointer to incomplete type
filesystems.c:33: dereferencing pointer to incomplete type
filesystems.c:33: dereferencing pointer to incomplete type
filesystems.c:33: warning: value computed is not used
make[2]: *** [filesystems.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5/fs'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/fs'
make: *** [_dir_fs] Error 2

I've gotta get ready for some stuff tomorrow, so I need to go to bed, but if
anyone posts a patch, I'll be sure to try it out ASAP. Relevant parts of the
config are here, any others can be provided.

# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
CONFIG_MODULES=y

-Jahn

