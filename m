Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290386AbSAXWRC>; Thu, 24 Jan 2002 17:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290378AbSAXWQw>; Thu, 24 Jan 2002 17:16:52 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:2395 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290376AbSAXWQl>; Thu, 24 Jan 2002 17:16:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Thu, 24 Jan 2002 23:16:29 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ed Sweetman <ed.sweetman@wmich.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201242152370.9957-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201242152370.9957-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020124221630.500F81101@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24. January 2002 21:54, Daniel Nofftz wrote:
> On Thu, 24 Jan 2002, Hans-Peter Jansen wrote:
> > You can see, enough idleness...
> >
> > The question is, why amd_disconnect=true causes this distortion. I tend
> > to believe that dis-/reconnecting CPU takes simply too long in this
> > scenario.
>
> hmmm ... yes ... this would be my idea too ... maybee the dis-reconnect
> procedure is to slow on "slow" computers to grant undisrupted audio or
> video streams ...
>
> i have no problem with this ... maybee caus i have a "faster" cpu ?

Asus A7V133 with 1.2 GHz Athlon:

<4>Detected 1224.230 MHz processor.
<4>Calibrating delay loop... 2444.49 BogoMIPS
<4>Memory: 771764k/786352k available (1104k kernel code, 14196k reserved, 
303k data, 224k 
init, 0k highmem)

System feels fast normally, and feels noticable slower with disconnected
feature. The problem with vlc is it's timing fragility to get smooth video 
and synchronous audio output. (I also need alsa > 0.9.0 and XVideo scaling 
on my Matrox G450 to get there, btw).

System is fast enough to compile the kernel during playback without a
hitch. CD copying with cdrdao is a different story. This would be my
ultimate latency check (but haven't played with low latency, yet).

If you like playing vcds and/or dvds, try vlc 0.2.92:
http://www.videolan.org/pub/videolan/vlc/0.2.92/vlc-0.2.92.tar.bz2
It's my stablest player so far. I'm trying mplayer CVS from time to
time, also xine, ogle but vlc is my personal favorite (I'm using a 0.2.92 
CVS version and play plain vob's from my server most of the time).
Ask me privately, if you need any help with such stuff..

> daniel
>
>
> # Daniel Nofftz
> # Sysadmin CIP-Pool Informatik
> # University of Trier(Germany), Room V 103
> # Mail: daniel@nofftz.de

Cheers,
  Hans-Peter
