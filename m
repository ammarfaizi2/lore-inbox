Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVBLOSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVBLOSl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 09:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVBLOSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 09:18:41 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:34194 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261405AbVBLOSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 09:18:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=d4CMhm3cTOsmDo/PcZ8vn+Ideu0KnFVH/oW9D6h5lqV8L5qrWrFMb42JE4yVbdo8z7W2cxhsSxGnDbifwvjJNGATv/LekK7o8wNcroW504x4aoKQD6liRtrQ0f3n7VjgKdL/D/hhSALO/9jlMN59OUrAHTPprdIahrRbN87SLYo=
Message-ID: <5a4c581d05021206186fa87d5e@mail.gmail.com>
Date: Sat, 12 Feb 2005 15:18:38 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Tomas Szepe <szepe@pinerecords.com>
Subject: Re: 2.6.11-rc3: intel8x0 alsa outputs no sound
Cc: Narayan Desai <desai@mcs.anl.gov>, John M Flinchbaugh <john@hjsoft.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050212002319.GA12498@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050204213337.GA12347@butterfly.hjsoft.com>
	 <874qgqu0ej.fsf@topaz.mcs.anl.gov>
	 <20050212002319.GA12498@louise.pinerecords.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Feb 2005 01:23:19 +0100, Tomas Szepe <szepe@pinerecords.com> wrote:
> On Feb-05 2005, Sat, 16:06 -0600
> Narayan Desai <desai@mcs.anl.gov> wrote:
> 
> > Try muting the headphone jack sense control with alsamixer. I had the
> > same problem with rc2 on my t41p, and that solved it.
> 
> This doesn't help on a T40p, I'm afraid.
> No sound in 2.6.11-rc3 with snd-intel8x0.ko, worked all ok in 2.6.10.

Sorry to jump late in the thread - apologies in advance if
 this info has already been provided...

On my Dell C640, onboard sound has been working forever,
 but it's a while since I have it in-kernel:

[root@incident root]# dmesg | grep -i intel8
intel8x0_measure_ac97_clock: measured 49438 usecs
intel8x0: clocking to 48000
[root@incident root]# grep -i 8X0 /usr/src/linux/.config
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=m
[root@incident root]# uname -a
Linux incident 2.6.11-rc3-bk7 #1 Fri Feb 11 10:12:09 CET 2005 i686
i686 i386 GNU/Linux

--alessandro
