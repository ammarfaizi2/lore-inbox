Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266399AbSIRMPf>; Wed, 18 Sep 2002 08:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266418AbSIRMPf>; Wed, 18 Sep 2002 08:15:35 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:8658 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S266399AbSIRMPe>;
	Wed, 18 Sep 2002 08:15:34 -0400
To: linux-kernel@vger.kernel.org
Subject: Audio problems on 2.4.20-pre5
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 18 Sep 2002 14:20:23 +0200
Message-ID: <m3hegnh4l4.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had this happen a few times on 2.4.20-preX, as this time I
thoguht it was time to ask what's up about it. Every once in a while
the machine will decide to not play audio, or play it at odd speeds,
after trying to play an mp3 now I got my syslog full of these:

i810_audio: DMA overrun on write
i810_audio: CIV 23, LVI 22, hwptr ba18, count -24
i810_audio: DMA overrun on write
i810_audio: CIV 23, LVI 22, hwptr bd00, count -232 

The sound init from dmesg is here:

i810: Intel ICH3 found at IO 0x4400 and 0x4000, MEM 0x0000 and 0x0000, IRQ 5
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ADS99(Unknown)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
i810_audio: setting clocking to 68246

Any pointer to why this happens?

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
