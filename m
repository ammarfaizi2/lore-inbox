Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277532AbRKVLxj>; Thu, 22 Nov 2001 06:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRKVLxT>; Thu, 22 Nov 2001 06:53:19 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:30468 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S277532AbRKVLxI>; Thu, 22 Nov 2001 06:53:08 -0500
Date: Thu, 22 Nov 2001 12:46:13 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: SYM2 driver: warnings about linux/malloc.h in 2.4.15-pre9
Message-ID: <20011122124613.A5067@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[3]: Entering directory `/usr/src/linux-2.4.15pre9/drivers/scsi/sym53c8xx_2'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.15pre9/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-al
iasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6  -I.  -c -o sym_fw.o sym_fw.c
In file included from sym_glue.h:80,
                 from sym_fw.c:56:
/usr/src/linux-2.4.15pre9/include/linux/malloc.h:4: warning: #warning linux/malloc.h is deprecated, use linux/slab.h instead.

there's more of these, and they may have been in earlier kernels as
well. This is when compiling on an Alpha, btw.

Good luck,
Jurriaan
-- 
"Oh", he said finally.
"And what's that supposed to mean?"
"It means he's thinking", said the unicorn. "Always a bad sign."
	Simon R Green - Blue Moon Rising
GNU/Linux 2.4.15-pre7 on Debian/Alpha 64-bits 988 bogomips load:0.13 0.24 0.24
