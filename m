Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270279AbRHSK3M>; Sun, 19 Aug 2001 06:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270314AbRHSK3C>; Sun, 19 Aug 2001 06:29:02 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:33698 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S270279AbRHSK2r>; Sun, 19 Aug 2001 06:28:47 -0400
Date: Sun, 19 Aug 2001 03:28:58 -0700
From: "Adam J. Richter" <adam@ns1.yggdrasil.com>
Message-Id: <200108191028.DAA01752@ns1.yggdrasil.com>
To: geert@linux-m68k.org
Subject: Re: [Linux-fbdev-devel] Patch, please TEST: linux-2.4.9 console font modularization
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        mj@ucw.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What's wrong with the ancient console ioctl()s to change the font at runtine?
>(damned, I can't remember the name of the command)
[...]
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

	I don't know enough about fbdev vs. the old PC VGA console 
to know whether those ioctl's are available for fbdev.

	As far as I'm concerned, loading fonts by user level programs
would be even better than by loading modules, although, I think that,
when trying to move a facility from kernel to userland, people are a
lot more willing to try that change if the kernel-based way is still
available, but normally just compiled as modules that people gradually
stop using.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
