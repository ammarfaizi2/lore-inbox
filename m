Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280154AbRKIVfP>; Fri, 9 Nov 2001 16:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280162AbRKIVfF>; Fri, 9 Nov 2001 16:35:05 -0500
Received: from omnis-mail.omnis.com ([216.239.128.28]:62482 "HELO omnis.com")
	by vger.kernel.org with SMTP id <S280154AbRKIVet>;
	Fri, 9 Nov 2001 16:34:49 -0500
Message-ID: <3BEC4C5C.8070603@sh.nu>
Date: Fri, 09 Nov 2001 13:36:28 -0800
From: Daniel Ceregatti <vi@sh.nu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011010
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: vi@sh.nu
Subject: Re: emu10k emits buzzing and crackling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

  > Hey folks,
  >
  > One of the workstations I use really doesn't like the emu10k driver in
  > 2.4.13-ac5. The box is a dual athlon running rh7.2. Playing mp3s seems
  > to work well, but other samples from xfce on shutdown and window close
  > result in buzzing and popping noises. If anyone wants details or patches
  > tested, drop me a note.
  >
  >                 -ben
  >
  > es1371: version v0.30 time 17:42:30 Nov 1 2001
  > Creative EMU10K1 PCI Audio Driver, version 0.16, 17:42:24 Nov 1 2001
  > emu10k1: EMU10K1 rev 7 model 0x8040 found, IO at 0x2400-0x241f, IRQ 19
  > ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
  > usb.c: registered new driver hub

I have the same problem. It started when I applied Gerd Knorr's V4L2
patches for bttv 0.8.x in 2.4.12. If I reverted back to the vanilla
2.4.12 kernel, all was fine.

This then became a problem in vanilla 2.4.13. It doesn't happen with all
apps, just apps that play small wav files (like "play"). Quake3 and xmms
don't have any issues.

I've tried the drivers on opensource.creative.com, but they haven't
helped. I'm now using the V4L2 patches for 2.4.13, and the problem is
still there.

Here's my driver info:

Creative EMU10K1 PCI Audio Driver, version 0.16, 23:24:09 Nov  5 2001
PCI: Found IRQ 7 for device 00:0c.0
PCI: Sharing IRQ 7 with 00:07.2
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xe400-0xe41f, IRQ 7
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR?????)

Please CC any response to vi@sh.nu, as I'm not on the list.

Thanks,

Daniel Ceregatti

