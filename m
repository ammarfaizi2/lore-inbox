Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRLGKvW>; Fri, 7 Dec 2001 05:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRLGKvM>; Fri, 7 Dec 2001 05:51:12 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:28938 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S274875AbRLGKvA>; Fri, 7 Dec 2001 05:51:00 -0500
Subject: 2.5.1pre6 compile error
From: "Martin A. Brooks" <martin@jtrix.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 07 Dec 2001 10:50:12 +0000
Message-Id: <1007722213.24166.2.camel@unhygienix>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/martin/kernel-a-day-club/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o ps2esdi.o ps2esdi.c
ps2esdi.c: In function `do_ps2esdi_request':
ps2esdi.c:498: switch quantity not an integer
ps2esdi.c:500: warning: unreachable code at beginning of switch
statement
make[3]: *** [ps2esdi.o] Error 1

-- 
Martin A. Brooks   Systems Administrator
Jtrix Ltd          t: +44 7395 4990
57-59 Neal Street  f: +44 7395 4991
London, WC2H 9PP   e: martin@jtrix.com

