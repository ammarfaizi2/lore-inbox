Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbSKGOP6>; Thu, 7 Nov 2002 09:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbSKGOP6>; Thu, 7 Nov 2002 09:15:58 -0500
Received: from [192.58.209.91] ([192.58.209.91]:45508 "HELO handhelds.org")
	by vger.kernel.org with SMTP id <S261177AbSKGOP5>;
	Thu, 7 Nov 2002 09:15:57 -0500
From: George France <france@handhelds.org>
To: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>,
       axp-list mailing list <axp-list@redhat.com>
Subject: Re: [PATCH] eliminate compile warnings
Date: Thu, 7 Nov 2002 09:22:26 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20021106214705.A15525@Marvin.DL8BCU.ampr.org>
In-Reply-To: <20021106214705.A15525@Marvin.DL8BCU.ampr.org>
MIME-Version: 1.0
Message-Id: <02110709222600.14483@shadowfax.middleearth>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 November 2002 16:47, Thorsten Kranzkowski wrote:
> Hello!
>
> My attempt to compile 2.5.46 with gcc 3.3 resulted in over 66% lines of the
> form:

You are brave sole. The bleeding edge cuts both ways.

>
> xyz.c: warning: comparison between signed and unsigned
>
> This is a first step to eliminate those, covering arch/alpha. Most fixes
> are obvious, but please check.
>
> BTW who is the current maintainer for Alpha issues? MAINTAINERS has no
> entry :-/

If there is no entry in the MAINTAINERS file, then it is Linus.  He did the Alpha port.
The first foray of Linux outside of the Intel architecture was to the Alpha processor.
The Alpha system came from the laboratories of the Digital Equipment Corp.  An engineer
 from Digital (now HP) arranged for a loan of an Alpha server to Linus Torvalds
for him to begin a port of Linux. This act of beneficence greatly accelerated the
migration of Linux to other platforms.  Linus is still the MAINTAINER for Alpha to this day.
He still has his loaner box from Digital.

There are still a few of us that work for the Alpha Processor Group at HP that work on
maintaining the kernel.  I have tossed your patch into the directory that holds all
kinds of miscellaneous alpha bits for the next time one of us looks at the kernel.
Since people that work on the Alpha Architecture are greatly outnumbered by the
people that work on other architectures, usually by the time we have a stable working 
kernel for Alpha, the kernel.org kernels are usually many versions ahead.  

I hope this helps.

Best Regards,


--George
