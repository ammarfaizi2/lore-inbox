Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283552AbRK3IGX>; Fri, 30 Nov 2001 03:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283554AbRK3IGN>; Fri, 30 Nov 2001 03:06:13 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:45070 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S283552AbRK3IF6>; Fri, 30 Nov 2001 03:05:58 -0500
Message-ID: <3758.10.119.8.1.1007107604.squirrel@extranet.jtrix.com>
Date: Fri, 30 Nov 2001 08:06:44 -0000 (GMT)
Subject: 2.5.1-pre4 compile error - pd.c
From: "Martin A. Brooks" <martin@jtrix.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.0 [rc2])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/martin/kernel-a-day-club/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o pd.o pd.c
pd.c: In function `do_pd_request':
pd.c:856: structure has no member named `bh'
pd.c: In function `pd_next_buf':
pd.c:881: `io_request_lock' undeclared (first use in this function)
pd.c:881: (Each undeclared identifier is reported only once
pd.c:881: for each function it appears in.)
pd.c: In function `do_pd_read_start':


--
Martin A. Brooks   Systems Administrator
Jtrix Ltd          t: +44 7395 4990
57-59 Neal Street  f: +44 7395 4991
London, WC2H 9PP   e: martin@jtrix.com


