Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289629AbSAWBqI>; Tue, 22 Jan 2002 20:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289631AbSAWBqA>; Tue, 22 Jan 2002 20:46:00 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:34055 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289629AbSAWBps>; Tue, 22 Jan 2002 20:45:48 -0500
Subject: 2.5.3-pre3 -- pcilynx.c:638: In function `mem_open': invalid
	operands to binary &
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 22 Jan 2002 17:44:48 -0800
Message-Id: <1011750288.24309.23.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o pcilynx.o pcilynx.c
pcilynx.c: In function `mem_open':
pcilynx.c:638: invalid operands to binary &
pcilynx.c:650: `num_of_cards' undeclared (first use in this function)
pcilynx.c:650: (Each undeclared identifier is reported only once
pcilynx.c:650: for each function it appears in.)
pcilynx.c:650: `cards' undeclared (first use in this function)
pcilynx.c: In function `aux_poll':
pcilynx.c:721: `cards' undeclared (first use in this function)
make[2]: *** [pcilynx.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/ieee1394'


