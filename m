Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279829AbRKILcH>; Fri, 9 Nov 2001 06:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279824AbRKILb5>; Fri, 9 Nov 2001 06:31:57 -0500
Received: from mta04ps.bigpond.com ([144.135.25.136]:59635 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S279832AbRKILbr>; Fri, 9 Nov 2001 06:31:47 -0500
Message-ID: <000701c16912$cf1915a0$0c01a8c0@vaio>
From: "Robert Lowery" <cangela@bigpond.net.au>
To: <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Assertion failure wth ext3 on standard Redhat 7.2 kernel
Date: Fri, 9 Nov 2001 22:36:44 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,


>ext3 downloads are currently running at 1,200 per day plus
>an unknown number of Red Hat users, and you're the first to report
>this one. So it's going to be something odd. It _could_ be bad
>hardware, but if it's always failing in the same way, that sounds
>unlikely.

I too thought bad hardware.  I will try removing the extra 64M I added
recently and see if it still happens.


>Could you please force a `fsck' against the fs, let us know the
>outcome?
After a crash I say Y (within 5 seconds) on reboot to run an fsck and there
are usually corrupted files from what I was doing when it crashed.  Eg I was
running rpm -Uvh kernel-sources... and some files in /usr/src/linux... were
corrupted.

>Also, a ksymoops trace of the oops output would be most useful.

How do I do this when the box has crashed?  I can manually write down the
oops, but then what do I do?  Can I manually look up System.map to get what
you need?


>It looks like memory corruption of some form - a structure
>member has an impossible value. Are you using any less-than-mainstream
>device drivers in that box?
I agree.  Everything is pointing to the new memory, even though I
successfully ran memtest86 for 10 hours.

Thanks

-Robert


