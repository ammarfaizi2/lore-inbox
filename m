Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316523AbSFDHyv>; Tue, 4 Jun 2002 03:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316526AbSFDHyu>; Tue, 4 Jun 2002 03:54:50 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:11538 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S316523AbSFDHyu>; Tue, 4 Jun 2002 03:54:50 -0400
Subject: Re: 2.5.20 -- /usr/include/linux/errno.h:4: asm/errno.h: No such
	file or directory
From: Miles Lane <miles@megapathdsl.net>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1023171718.7825.1.camel@agate>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 04 Jun 2002 01:15:30 -0700
Message-Id: <1023178531.7829.35.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 23:21, Miles Lane wrote:
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o split-include
> split-inIn file included from /usr/include/bits/errno.h:25,
>                  from /usr/include/errno.h:36,
>                  from split-include.c:26:
> /usr/include/linux/errno.h:4: asm/errno.h: No such file or directory
> make[1]: *** [split-include] Error 1
> 
> I recall seeing a comment that egcs support was being removed.
> I am building on a machine I haven't used in a while and 
> just noticed it has egcs on it.  If this error is egcs-specific,
> could we please check the gcc version and emit an error stating
> that egcs isn't supported?

I figured out I needed a copy of the 2.2 kernel headers for egcs
to work.  I think I made enough room to build gcc 2.95.3 (which is
listed as the gcc to use in Documentation/Changes).

	Miles

