Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136686AbREGV6J>; Mon, 7 May 2001 17:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136690AbREGV6A>; Mon, 7 May 2001 17:58:00 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:42678 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S136686AbREGV5v>; Mon, 7 May 2001 17:57:51 -0400
Message-Id: <5.1.0.14.2.20010507225609.00a95440@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 May 2001 22:58:29 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian Gerst <bgerst@didntduck.org>,
        linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:12 07/05/2001, Linus Torvalds wrote:
>In particular, does anybody have a buggy Pentium to test with the F0 0F
>lock-up bug?
[snip]
>If anybody has such a beast, please try this kernel patch _and_ running

Still works ok (2.4.5-pre1 + patch). SIGILL is sent.

Best regards,

Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

