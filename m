Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290545AbSAYET4>; Thu, 24 Jan 2002 23:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290541AbSAYETp>; Thu, 24 Jan 2002 23:19:45 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:6419 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S290545AbSAYETi>; Thu, 24 Jan 2002 23:19:38 -0500
Subject: 2.5.3-pre5 -- "pcilynx.c:638: invalid operands to binary &"  and 
	"pcilynx.c:650: `cards' undeclared"
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 24 Jan 2002 20:18:26 -0800
Message-Id: <1011932306.18088.162.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ld -m elf_i386 -r -o ieee1394.o ieee1394_core.o ieee1394_transactions.o
hosts.o highlevel.o csr.o nodemgr.o
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
pcilynx.o pcilynx.c
pcilynx.c: In function `mem_open':
pcilynx.c:638: invalid operands to binary &
pcilynx.c:650: `num_of_cards' undeclared (first use in this function)
pcilynx.c:650: (Each undeclared identifier is reported only once
pcilynx.c:650: for each function it appears in.)
pcilynx.c:650: `cards' undeclared (first use in this function)
pcilynx.c: In function `aux_poll':
pcilynx.c:721: `cards' undeclared (first use in this function)


