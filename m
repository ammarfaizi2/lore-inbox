Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135760AbRDTHuf>; Fri, 20 Apr 2001 03:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135821AbRDTHuZ>; Fri, 20 Apr 2001 03:50:25 -0400
Received: from denise.shiny.it ([194.20.232.1]:4490 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S135760AbRDTHuQ>;
	Fri, 20 Apr 2001 03:50:16 -0400
Message-ID: <XFMail.010420094955.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010419173611.A26995@kybl>
Date: Fri, 20 Apr 2001 09:49:55 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Tomas Jura <tjura@binghamton.edu>
Subject: Re: I can eject a mounted CD
Cc: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> [Giu@Jay Giu]$ eject /mnt/cdmac/ umount: /dev/sr0 is not in the fstab (and
>> you are not root) eject: unmount of `/dev/sr0' failed

Eject(1) is suid.

> I have similar problem with my swim3 floppy drive. Digging deeply I found that
> when I make do folowing steps then disk is lost and I have to reboot to get it
> back:

I can't try this case because I haven't a floppy. When I ehect the cd I can
recover it by unmounting it. But the CD is read-only. I can try with a MO, but
the actual problem is that eject is buggy. It's not a kernel bug. I'll fix it...


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

