Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264216AbTDPETS (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 00:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264217AbTDPETS 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 00:19:18 -0400
Received: from haw-66-102-130-200.vel.net ([66.102.130.200]:8388 "HELO
	mx100.mysite4now.com") by vger.kernel.org with SMTP id S264216AbTDPETR 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 00:19:17 -0400
From: Udo Hoerhold <maillists@goodontoast.com>
To: Alistair Strachan <alistair@devzero.co.uk>
Subject: Re: SoundBlaster Live! with kernel 2.5.x
Date: Wed, 16 Apr 2003 00:29:22 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200304160140.23873.alistair@devzero.co.uk>
In-Reply-To: <200304160140.23873.alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304160029.22234.maillists@goodontoast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 April 2003 08:40 pm, Alistair Strachan wrote:
> Udo Hoerhold wrote:
> > Hello,
> >
> > I've been running Debian woody with 2.4.20 kernel.  I'm trying to switch
> > to
> > 2.5.  I built 2.5.67 with emu10k driver in the kernel (same as I had with
> > 2.4.20), but I get only a lot of popping sounds from the sound card.  I
> > also
> > tried 2.5.50 and 2.5.67-mm3, with the same result.  I googled for emu10k
> > and soundblaster with 2.5, but I haven't seen anyone else with the same
> > problem. Does anyone know what this problem is?
>
> Are you using the OSS or ALSA driver?
>
> [alistair] 01:38am [~] dmesg | egrep -e EMU10K1
> Creative EMU10K1 PCI Audio Driver, version 0.20, 15:35:08 Apr 14 2003
> emu10k1: EMU10K1 rev 7 model 0x8026 found, IO at 0xe400-0xe41f, IRQ 12
>
> The soundcard is working perfectly with the OSS driver, for me, in
> 2.5.67-mm1. I'm running the latest version of the emu-tools. Please try
> matching this configuration.
>
> Cheers,
> Alistair.
>

OK, I was using ALSA, but I tried OSS instead.  I don't get the popping sounds 
anymore, but I don't get any sound at all.

udo:~$ dmesg | grep EMU10K
Creative EMU10K1 PCI Audio Driver, version 0.20, 20:58:14 Apr 15 2003
emu10k1: EMU10K1 rev 7 model 0x8061 found, IO at 0xdf80-0xdf9f, IRQ 10

Maybe this is not a kernel problem now, although 2.4.20 worked without any 
other configuration.  I'm running KDE, and I don't have emu-tools, but maybe 
I can poke around and see if I can find the problem.

Thanks,

Udo


