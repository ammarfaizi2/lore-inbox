Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281521AbRKPTvd>; Fri, 16 Nov 2001 14:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281525AbRKPTvN>; Fri, 16 Nov 2001 14:51:13 -0500
Received: from net24-164-102-119.neo.rr.com ([24.164.102.119]:52096 "EHLO
	nova.qfire.net") by vger.kernel.org with ESMTP id <S281521AbRKPTvJ>;
	Fri, 16 Nov 2001 14:51:09 -0500
From: James Cassidy <jcassidy@nova.qfire.net>
Date: Fri, 16 Nov 2001 14:51:07 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Via686b audio
Message-ID: <20011116145107.A13649@qfire.net>
In-Reply-To: <1005936427.3321.2.camel@smiddle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1005936427.3321.2.camel@smiddle>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I also noticed that the audio driver (via82cxxx_audio) gives a message
> that it is for 82C686a (not 686b, which is what my motherboard is), and
> then errors about timeouts on the AC97 codec - is it possible the 686b
> is a little different than 686a in how the AC97 stuff is handled?  I'm
> more than willing to apply patches or make small kernel tweaks, if
> anyone can tell me what I need to do to debug this and get it working.
> 
> I've spoken with another person attempting to get Linux running on the
> same laptop series (Compaq Presario 700), and it seems we have similar
> issues.  If that makes any difference to anyone.  ^,^

	I'm the one that Sean is refering to and I'd just like to
add some information I've noticed.
	If I turn the volume all the way up I can faintly hear the
music playing, like I was hearing it because of crosstalk on the chip.
At first I thought it was just my wishful thinking playing tricks
on me but it is definetly there :). Now it appears if I adjust the
PCM volume it controls this faint whisper but controling the main volume
does nothing. 
	Also, I no longer see the timeouts on the AC97 codec with the
newer kernels. The ID for the codec is 0x41445361 (AD1886 according to alsa 
drivers). This codec is not currently recognized by the kernel's ac97_codec 
drivers.
	I'm also willing to try any kernel tweaking/patches, and gather
more debug info if need be.
						-- James (QFire)
