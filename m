Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSDOPVJ>; Mon, 15 Apr 2002 11:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312850AbSDOPVI>; Mon, 15 Apr 2002 11:21:08 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:55751 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S312486AbSDOPVI>;
	Mon, 15 Apr 2002 11:21:08 -0400
Message-ID: <032301c1e491$1da99b50$e1de11cc@csihq.com>
Reply-To: "Mike Black" <mblack@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.5.8 minix compile problem
Date: Mon, 15 Apr 2002 11:20:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-Mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patched my 2.5.7 tree with 2.5.8:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.7/include -Wall -Wstrict-prototypes -W
no-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
 -mpreferred-stack-boundary=2 -march=i686  -DUTS_MACHINE='"i386"' -DKBUILD_B
ASENAME=version -c -o init/version.o init/version.c
make: *** No rule to make target
`/usr/src/linux-2.5.7/include/linux/minix_fs_i.h', needed by
`/usr/src/linux-2.5.7/include/linux/minix_fs.h'.  Stop.

MINIX was compiled as a module.

When compiled into kernel it builds fine.

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

