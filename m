Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316475AbSFDGBR>; Tue, 4 Jun 2002 02:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316489AbSFDGBQ>; Tue, 4 Jun 2002 02:01:16 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:11273 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S316475AbSFDGBQ>; Tue, 4 Jun 2002 02:01:16 -0400
Subject: 2.5.20 -- /usr/include/linux/errno.h:4: asm/errno.h: No such file
	or directory
From: Miles Lane <miles@megapathdsl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 03 Jun 2002 23:21:57 -0700
Message-Id: <1023171718.7825.1.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o split-include
split-inIn file included from /usr/include/bits/errno.h:25,
                 from /usr/include/errno.h:36,
                 from split-include.c:26:
/usr/include/linux/errno.h:4: asm/errno.h: No such file or directory
make[1]: *** [split-include] Error 1

I recall seeing a comment that egcs support was being removed.
I am building on a machine I haven't used in a while and 
just noticed it has egcs on it.  If this error is egcs-specific,
could we please check the gcc version and emit an error stating
that egcs isn't supported?

	Miles

