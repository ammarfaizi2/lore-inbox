Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319046AbSHFK02>; Tue, 6 Aug 2002 06:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319047AbSHFK02>; Tue, 6 Aug 2002 06:26:28 -0400
Received: from mail-fe71.tele2.ee ([212.107.32.235]:50617 "HELO everyday.com")
	by vger.kernel.org with SMTP id <S319046AbSHFK01> convert rfc822-to-8bit;
	Tue, 6 Aug 2002 06:26:27 -0400
Date: Tue, 6 Aug 2002 12:30:01 +0200
Message-Id: <200208061030.MAA20559@eday-fe3.tele2.ee>
From: "Thomas Munck Steenholdt" <tmus@get2net.dk>
Cc: linux-kernel@vger.kernel.org
To: "Jeff Chua" <jeffchua@silk.corp.fedex.com>
Subject: Sv: i810 sound broken...
MIME-Version: 1.0
X-EdMessageId: 1a1955114211574f4b464b4a5349164d5e59105e1f5d515b5c14104f54535b63554573
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On 5 Aug 2002, Thomas Munck Steenholdt wrote:
> 
> > So anyway - How should I go about determining the exact problem on my
> > box... I've had it all along, and I know for a fact that the hardware
> is
> > OK... Modules are loaded correctly, but it just does not work!
> 
> Try me ...
> download aumix from http://jpj.net/~trevor/aumix/aumix-2.7.tar.gz
> and drag "Vol" and "Pcm" to appropriate level before you play any sound.
> 
> Jeff
> 

I'm afraid even that didn't help much - Only now I get a different kind of error... Before, trying to play a sound, the operation would just fisish immediatelyand a few noises were heard in the speakers... Now the operation never finishes - still no sound... and I found these error messages in dmesg..

dmesg:
--------------------------------------------------------------
Intel 810 + AC97 Audio, version 0.21, 11:44:41 Aug  6 2002
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH2 found at IO 0x1880 and 0x1c00, IRQ 11
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: 0x4144:0x5362 (Unknown)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
i810_audio: drain_dac, dma timeout?


Any more suggestions?

Thomas

-- Send gratis SMS og brug gratis e-mail på Everyday.com -- 

