Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBGMuz>; Wed, 7 Feb 2001 07:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129219AbRBGMup>; Wed, 7 Feb 2001 07:50:45 -0500
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:26497 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S129072AbRBGMuc>; Wed, 7 Feb 2001 07:50:32 -0500
Date: Wed, 7 Feb 2001 07:50:28 -0500 (EST)
From: Arthur Pedyczak <arthur-p@home.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Oopses in 2.4.1  (lots of them)
In-Reply-To: <E14QQkR-0008B6-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0102070735590.4661-100000@cs865114-a.amp.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Alan Cox wrote:

> > report got ignored). After running for 4 days I got many, many oopses.
> > They were trigerred by xscreensaver, and some other X-related apps.
> > After dopping to runlevel 3, the system seemed O.K. Nothing unusual in
> > graphics: Riva TNT2
>
> That makes it harder to say 'Use a 3.3.6 X server'. If you are using the
> nvidia binary/obfuscated modules for their 3d and stuff try running without
> them.
>
> Alan
>
Well,
NVidia is only one of the few suspects I have to eliminate. I also used
OSS, vmware, and free s/wan (for IPSEC). So now I am in a process of
eliminating them one by one.
Also, last night Linus suggested that this could be a hardware problem. I
am not sure how to eliminate or confirm this. Recently I added some RAM
(256->384) and decided to get rid of swap. This seemed to have destabilized
the system, although nothing is obvious. I can try to stress the system by
copying 2 CDs to files simultaneously, while running kernel build in the
background and tar-gzipping /usr, all at once. The load goes through the
roof, but everything works. Then, few hours later with no load a simple
thing like xscreensaver or makewhathis.cron would oops for no apparent
reason.
Not sure what to make of this all. Any ideas?

Arthur

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
