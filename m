Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267475AbRGTXrW>; Fri, 20 Jul 2001 19:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267480AbRGTXrC>; Fri, 20 Jul 2001 19:47:02 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:49166 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S267475AbRGTXq7>; Fri, 20 Jul 2001 19:46:59 -0400
Subject: 2.4.7 Build failure -- ohci1394.c:1451:19: #if with no expression
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 20 Jul 2001 16:43:49 -0700
Message-Id: <995672629.17744.9.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


make[2]: Entering directory `/usr/src/linux/drivers/ieee1394'
[...]
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
ohci1394.o ohci1394.c
ohci1394.c:1451:19: #if with no expression
make[2]: *** [ohci1394.o] Error 1

