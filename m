Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSGUT7f>; Sun, 21 Jul 2002 15:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSGUT7e>; Sun, 21 Jul 2002 15:59:34 -0400
Received: from dsl-213-023-043-192.arcor-ip.net ([213.23.43.192]:44189 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314835AbSGUT7d>;
	Sun, 21 Jul 2002 15:59:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Mark Spencer <markster@linux-support.net>
Subject: Re: Zaptel Pseudo TDM Bus
Date: Sun, 21 Jul 2002 22:04:06 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0207211359210.25617-100000@hoochie.linux-support.net>
In-Reply-To: <Pine.LNX.4.33.0207211359210.25617-100000@hoochie.linux-support.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17WMw3-0008CC-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 July 2002 21:01, Mark Spencer wrote:
> > A random question: is there any reason why Ogg isn't among the codecs?
> 
> It wasn't ready when I started.  Ogg, like mp3, is generally a very poor
> choice of codec for telephony, and even for the storage of files, unless
> its performance has improved greatly.

I don't know about performance (except for quality: it's said to require 
about half the bitrate for the same quality, compared to mp3) however, it
has one killer advantage over mp3: it's patent-free, and hence, royalty-free. 
I'd think that would be important for your project.

> On a 900 Mhz Athlon, you can get *hundreds* of simultaneous full-duplex
> GSM full-rate codecs running.  Certainly that's an unrealistic expectation
> even for half-duplex ogg or mp3.

But that would be an argument against supporting mp3 as well.

> As for using ogg as an actual telephony
> protocol, its frame size is (or at least was at the time I contacted the
> author) much too long to be practical.  Frame sizes for VoIP should be
> around 160 to 240 samples in general.

On a quick reading, this appears to indicate you can easily have what you 
want:

   http://www.xiph.org/ogg/vorbis/doc/framing.html

Perhaps the last time you looked at Ogg the streaming format had not yet been 
completed?

Also, doesn't part of telephony consist of having lots of pre-recorded audio 
around, for voice mail etc?  Granted, an encoder optimized for music is not 
necessarily optimzed for voice.  However, would that not be a matter of 
tweaking the encoder?  As I understand it, the vorbis compression format is 
quite general, and in fact, all the recent work that improved the quality so 
noticably involved only the encoder.

OK, this isn't a really kernel issue, so... I'll clamp my hams and post it 
anyway ;-)

-- 
Daniel
