Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbRAAV7z>; Mon, 1 Jan 2001 16:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbRAAV7p>; Mon, 1 Jan 2001 16:59:45 -0500
Received: from punt1.cix.co.uk ([212.35.225.148]:59118 "EHLO punt1.cix.co.uk")
	by vger.kernel.org with ESMTP id <S129778AbRAAV7f>;
	Mon, 1 Jan 2001 16:59:35 -0500
X-Envelope-From: wish@dumain.com
Message-Id: <200101012129.f01LTJL27315@punt1.cix.co.uk>
>Return-Path: <wish@dumain.com>
To: Matt Wright <matt@teletubbies.dhs.org>
From: wish-kernel@dumain.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-testX fails to compile on my Athlon 
In-Reply-To: Your message of "Sun, 31 Dec 2000 16:42:37 PST."
             <Pine.LNX.4.21.0012311635530.1649-100000@po.teletubbies.dhs.org> 
Date: Mon, 01 Jan 2001 20:01:30 +0000
Content-Type: text
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've looked for answers to this question before, but all I could find was
> someone asking a similar question and no replies...
> 
> I'm having great trouble getting 2.4.0-testX to compile on my system when
> I select Athlon/K7 as the Processor Family....
[snip]
> /root/source/linux/include/asm/string.h: In function `__memcpy3d':
> /root/source/linux/include/asm/string.h:312: `current' undeclared (first
> use in this function)
> make: *** [init/main.o] Error 1
> [root@dipsy linux]# 
Are you trying to compile for SMP as well?  I've seen similar
errors when selecting Athlon with SMP by mistake.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
