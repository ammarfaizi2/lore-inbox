Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRKNS6J>; Wed, 14 Nov 2001 13:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRKNS6B>; Wed, 14 Nov 2001 13:58:01 -0500
Received: from mail102.mail.bellsouth.net ([205.152.58.42]:51171 "EHLO
	imf02bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S275265AbRKNS5x>; Wed, 14 Nov 2001 13:57:53 -0500
Message-ID: <3BF2BE98.3205C11C@mandrakesoft.com>
Date: Wed, 14 Nov 2001 13:57:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stuart MacDonald <stuartm@connecttech.com>
CC: tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Fw: [Patch] Some updates to serial-5.05
In-Reply-To: <00df01c16d23$b409ab20$294b82ce@connecttech.com> <3BF2947B.DF3BE9DC@mandrakesoft.com> <013d01c16d29$bc5d4380$294b82ce@connecttech.com> <3BF29D69.B16479A1@mandrakesoft.com> <02b901c16d3c$a4e4adc0$294b82ce@connecttech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart MacDonald wrote:
> > Doubtful.  When applied to 2.4.x-current:
> >
> > [jgarzik@rum linux_2_4]$ patch drivers/char/serial.c < ~/tmp/patch
> > patching file drivers/char/serial.c
> > Hunk #1 FAILED at 1405.
> > Hunk #2 FAILED at 2514.
> > Hunk #3 FAILED at 2572.
> > Hunk #4 FAILED at 3968.
> > patch: **** malformed patch at line 55: {
> 
> You're right, the patches tend not to apply to non-5.05 versions.
> However, applying them to 2.4.14 doesn't give me the above. What
> exactly is 2.4.x-current, and where can I get it?

ftp://ftp.kernel.org/pub/linux/kernel/testing/

But it looks like your patch should be able to apply with little or no
modification, versus 2.4.15-pre4 or 2.4.14 release.


> I'll do a patch set against 5.05c, should rmk or tytso request it.
> Unless you're also a serial maintainer of some description?

I converted serial.c to support cardbus/hotplug, and have merged a patch
or two due to absence of maintainer...

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

