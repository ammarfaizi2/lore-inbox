Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269050AbRG3Rw6>; Mon, 30 Jul 2001 13:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269046AbRG3Rwk>; Mon, 30 Jul 2001 13:52:40 -0400
Received: from mail50-s.fg.online.no ([148.122.161.50]:57493 "EHLO
	mail50.fg.online.no") by vger.kernel.org with ESMTP
	id <S269050AbRG3RwX> convert rfc822-to-8bit; Mon, 30 Jul 2001 13:52:23 -0400
Message-ID: <000501c11920$65936190$01000001@pompel>
From: "Ola Garstad" <olag@eunet.no>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Error compliing 2.4.7. Earlier versions are ok.
Date: Mon, 30 Jul 2001 19:52:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Pentium 233 MMX, 96MB RAM, RH 7.0

I get the following:

make[3]: Entering directory `/disk2/src/linux-2.4.7/drivers/block'
kgcc -D__KERNEL__ -I/disk2/src/linux-2.4.7/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-ali
asing -fno-common -pipe  -march=i586    -DEXPORT_SYMTAB -c ll_rw_blk.c
/disk2/src/linux-2.4.7/include/asm/string.h: In function `strncmp':
In file included from /disk2/src/linux-2.4.7/include/linux/string.h:25,
                 from /disk2/src/linux-2.4.7/include/linux/fs.h:23,
                 from /disk2/src/linux-2.4.7/include/linux/capability.h:17,
                 from /disk2/src/linux-2.4.7/include/linux/binfmts.h:5,
                 from /disk2/src/linux-2.4.7/include/linux/sched.h:9,
                 from ll_rw_blk.c:14:
/disk2/src/linux-2.4.7/include/asm/string.h:144: `d1' undeclared (first use in this function)
/disk2/src/linux-2.4.7/include/asm/string.h:144: (Each undeclared identifier is reported only once
/disk2/src/linux-2.4.7/include/asm/string.h:144: for each function it appears in.)
/disk2/src/linux-2.4.7/include/asm/string.h:130: warning: unused variable `d1'

