Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280748AbRKYHUM>; Sun, 25 Nov 2001 02:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280749AbRKYHTy>; Sun, 25 Nov 2001 02:19:54 -0500
Received: from mail008.syd.optusnet.com.au ([203.2.75.232]:48773 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S280748AbRKYHTa>; Sun, 25 Nov 2001 02:19:30 -0500
Message-Id: <200111250718.fAP7IHJ03935@mail008.syd.optusnet.com.au>
Content-Type: text/plain; charset=US-ASCII
From: Michael Covi <thebaron22@optushome.com.au>
To: Dietmar Schmidt <D.Schmidt@aquadetox.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: missing "drivers/hotplug" tree in 2.4.14 and the 2.4.15-patch
Date: Sun, 25 Nov 2001 18:18:17 +1100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200111242000.VAA17709@terra.aquadetox.int>
In-Reply-To: <200111242000.VAA17709@terra.aquadetox.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you checked to make sure you have your swap mounted ok?

I had a similar problem last week after doing a install with a unfamiliar 
distribution.  I had allocated 512M but for some reason mkswap was not run.
So when i tried to use a memory hungry app OOM killed it as it should.

On Sun, 25 Nov 2001 07:00, Dietmar Schmidt wrote:
> Hello,
>
> I'm running 2.4.14 on top of a SuSE Linux 7.3 distribution. I took the
> complete sources myself from kernel.org corr. to an older Latest-Is
> Announce.
>
> Installing, configuring, compiling and all went fine with 2.4.14 so far...
> (in fact it works fine for me although SuSE-Kernels in some way differ from
> orginal sources...)
>
> My /proc/version (although I don't think it important for the further
> problem
>
> description...) gives:
> > Linux version 2.4.14 (root@sirius) (gcc version 2.95.3 20010315 (SuSE))
>
> Today I downloaded patch-2.4.15 and applied it. As I suggest it went okay
> as no Hmm..'s came up.
>
> When trying to configure the 2.4.15 kernel (using "make menuconfig") from
> an konsole within kde the latter crashed.
>
> Checking for the cause /var/log/messages gave:
> > Nov 24 19:06:31 sirius kernel: Out of Memory: Killed process 2595
> > (kdeinit). Nov 24 19:06:37 sirius kernel: Out of Memory: Killed process
> > 2593 (kdeinit). Nov 24 19:06:39 sirius kernel: Out of Memory: Killed
> > process 2604 (kdeinit).
>
