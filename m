Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281505AbRLAIlH>; Sat, 1 Dec 2001 03:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283945AbRLAIk6>; Sat, 1 Dec 2001 03:40:58 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:20233 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S281505AbRLAIkp>; Sat, 1 Dec 2001 03:40:45 -0500
Message-ID: <2381.10.119.8.1.1007196092.squirrel@extranet.jtrix.com>
Date: Sat, 1 Dec 2001 08:41:32 -0000 (GMT)
Subject: 2.5.1pre5 compile error - rd.c
From: "Martin A. Brooks" <martin@jtrix.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.0 [rc2])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/martin/kernel-a-day-club/linux/include -Wall -
Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-
aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -
o rd.o rd.c
rd.c:561: `rd_cleanup' undeclared here (not in a function)
make[3]: *** [rd.o] Error 1

--
Martin A. Brooks   Systems Administrator
Jtrix Ltd          t: +44 7395 4990
57-59 Neal Street  f: +44 7395 4991
London, WC2H 9PP   e: martin@jtrix.com


