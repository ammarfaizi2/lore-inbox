Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131077AbRCJR5D>; Sat, 10 Mar 2001 12:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131078AbRCJR4x>; Sat, 10 Mar 2001 12:56:53 -0500
Received: from mailout1-100bt.midsouth.rr.com ([24.92.68.6]:21137 "EHLO
	mailout1-100bt.midsouth.rr.com") by vger.kernel.org with ESMTP
	id <S131077AbRCJR4j>; Sat, 10 Mar 2001 12:56:39 -0500
Message-Id: <200103101754.f2AHsUL04580@mailout1-100bt.midsouth.rr.com>
Subject: Re: Kernel 2.4.1 on RHL 6.2
From: Stephen "M." Williams <rootusr@midsouth.rr.com>
To: Srinath Ravinathan <sriguhan@eth.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001401c0a970$ec3c9b00$1d9509ca@pentiumiii>
Content-Type: text/plain
X-Mailer: Evolution (0.9/+cvs.2001.03.06.23.22 - Preview Release)
Date: 10 Mar 2001 11:53:17 -0600
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure you have the following symlinks in your /usr/include
directory, assuming you're on an x86 machine:

asm -> /usr/src/linux/include/asm-i386/
linux -> /usr/src/linux/include/linux/

If you're using a different archetecture, check the
/usr/src/linux/include/ directory and make the link with that directory.

Steve


On 10 Mar 2001 20:16:34 +0530, Srinath Ravinathan wrote:
> Hi,
>     I'm trying to compile kernel 2.4.1 on RedHat 6.2 (zoot). After the make xconfig and make dep when I give make bzlilo I get the following error message
> 
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o 
> scripts/split-include
> scripts/split-include.c
> In file included from /usr/include/errno.h:36,
>                  from scripts/split-include.c:26:
> /usr/include/bits/errno.h:25: linux/errno.h: No such file or directory
> make: *** [scripts/split-include] Error 1
> 
> What should I do?
> Yours ,
> Srinath.R
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

