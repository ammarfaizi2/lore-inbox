Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283328AbRK3I5y>; Fri, 30 Nov 2001 03:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282404AbRK3I5o>; Fri, 30 Nov 2001 03:57:44 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:27152 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S283328AbRK3I5b>; Fri, 30 Nov 2001 03:57:31 -0500
Message-ID: <4199.10.119.8.1.1007110697.squirrel@extranet.jtrix.com>
Date: Fri, 30 Nov 2001 08:58:17 -0000 (GMT)
Subject: Re: 2.5.1-pre4 compile error - pd.c
From: "Martin A. Brooks" <martin@jtrix.com>
To: <axboe@suse.de>
In-Reply-To: <20011130092347.L16796@suse.de>
In-Reply-To: <20011130092347.L16796@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.0 [rc2])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Please try this diff.

That seems to fix that error, but I now get a (possibly related) error
elsewhere.


gcc -D__KERNEL__ -I/home/martin/kernel-a-day-club/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o xd.o xd.c
xd.c: In function `xd_geninit':
xd.c:250: `max_sectors' undeclared (first use in this function)
xd.c:250: (Each undeclared identifier is reported only once
xd.c:250: for each function it appears in.)
make[3]: *** [xd.o] Error 1


--
Martin A. Brooks   Systems Administrator
Jtrix Ltd          t: +44 7395 4990
57-59 Neal Street  f: +44 7395 4991
London, WC2H 9PP   e: martin@jtrix.com


