Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132685AbRDLGy7>; Thu, 12 Apr 2001 02:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132692AbRDLGyt>; Thu, 12 Apr 2001 02:54:49 -0400
Received: from mail.gator.com ([63.197.87.182]:13064 "EHLO mail.gator.com")
	by vger.kernel.org with ESMTP id <S132685AbRDLGyj>;
	Thu, 12 Apr 2001 02:54:39 -0400
From: "George Bonser" <george@gator.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.4-pre2 nbd compile error
Date: Wed, 11 Apr 2001 23:56:27 -0700
Message-ID: <CHEKKPICCNOGICGMDODJCEHHCLAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall -Wstrict-prototypes -O
2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary
=2 -march=i686 -DMODULE -DMODVERSIONS -include
/usr/local/src/linux/include/linux/modversions.h   -c -o nbd.o nbd.c
nbd.c: In function `nbd_send_req':
nbd.c:160: `MSG_MORE' undeclared (first use in this function)
nbd.c:160: (Each undeclared identifier is reported only once
nbd.c:160: for each function it appears in.)
nbd.c: At top level:
nbd.c:481: warning: static declaration for `nbd_init' follows non-static

