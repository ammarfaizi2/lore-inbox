Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283498AbRK3EvY>; Thu, 29 Nov 2001 23:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283502AbRK3EvP>; Thu, 29 Nov 2001 23:51:15 -0500
Received: from news.heim1.tu-clausthal.de ([139.174.234.200]:28701 "EHLO
	neuemuenze.heim1.tu-clausthal.de") by vger.kernel.org with ESMTP
	id <S283498AbRK3EvA>; Thu, 29 Nov 2001 23:51:00 -0500
Date: Fri, 30 Nov 2001 05:51:07 +0100
From: Sven.Riedel@tu-clausthal.de
To: Erik Andersen <andersen@codepoet.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: via82cxxx_audio doesn't play audio?
Message-ID: <20011130055107.A14305@moog.heim1.tu-clausthal.de>
In-Reply-To: <20011129190617.A3975@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011129190617.A3975@codepoet.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 07:06:17PM -0700, Erik Andersen wrote:
> But standard apps such as xmms produce no sound.  Does this
> driver not work for anyone else? 

Yeah, works for me on an Epox 8KTA3+ pro, same module.

PCI: Found IRQ 12 for device 00:07.5
ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (ICE1232)
via82cxxx: board #1 at 0x9C00, IRQ 12

Bus  0, device   7, function  5:
   Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
      Controller (rev 80).
      IRQ 12.
      I/O at 0x9c00 [0x9cff].
      I/O at 0xa000 [0xa003].
      I/O at 0xa400 [0xa403].

Alsa otoh doesn't work for me (it used to, but then...).

Which mixer do you use? gom works for me, maybe different mixers don't
work with all cards (I had that problem with 2.0 kernels, don't know
about todays state, though).

Regs,
Sven

-- 
Sven Riedel                      sr@gimp.org
Osteroeder Str. 6 / App. 13      sven.riedel@tu-clausthal.de
38678 Clausthal                  "Call me bored, but don't call me boring."
                                 - Larry Wall 
