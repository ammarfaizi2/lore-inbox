Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSFTMrT>; Thu, 20 Jun 2002 08:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSFTMrS>; Thu, 20 Jun 2002 08:47:18 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:46548 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S314077AbSFTMrQ>;
	Thu, 20 Jun 2002 08:47:16 -0400
Message-ID: <02f101c21858$7970f5f0$f6de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Neil Brown" <neilb@cse.unsw.edu.au>
Subject: 2.5.23 LVM
Date: Thu, 20 Jun 2002 08:46:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI...after applying Neil's latest patches for raid got this (not Neil's fault)...I'm not currently using LVM so I disabled it.
Good news is that it all compiled (yeah!!! -- first time in months that I've been able to compile with RAID5)
Other question -- it looks like the 2.5 build now builds modules automagically instead of saying "make modules" ???
Hopefully I'll get chance to test 2.5 soon.

  gcc -Wp,-MD,./.lvm.o.d -D__KERNEL__ -I/usr/src/linux-2.5.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-poin
ter -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE   -DKBUI
LD_BASENAME=lvm   -c -o lvm.o lvm.c
lvm.c:1: #error Broken until maintainers will sanitize kdev_t handling
lvm.c: In function `lvm_blk_ioctl':
lvm.c:882: warning: implicit declaration of function `fsync_bdev'
lvm.c:883: warning: implicit declaration of function `invalidate_buffers'
lvm.c: In function `lvm_user_bmap':
lvm.c:1023: structure has no member named `bi_dev'
lvm.c:1024: structure has no member named `bi_dev'
lvm.c:1032: structure has no member named `bi_dev'
lvm.c:1032: structure has no member named `bi_dev'
lvm.c:1032: structure has no member named `bi_dev'
lvm.c:1032: structure has no member named `bi_dev'

Michael D. Black mblack@csihq.com
http://www.csihq.com/
http://www.csihq.com/~mike
321-676-2923, x203
Melbourne FL

