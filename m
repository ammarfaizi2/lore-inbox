Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271164AbRHOMFN>; Wed, 15 Aug 2001 08:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271165AbRHOMFD>; Wed, 15 Aug 2001 08:05:03 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:50961 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S271164AbRHOMEx>;
	Wed, 15 Aug 2001 08:04:53 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 15 Aug 2001 14:02:32 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BT878 audio dma
Message-ID: <20010815140232.A5029@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B7A5FCF.F4C9561F@delusion.de>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 01:41:03PM +0200, Udo A. Steinberg wrote:
> 
> Hi Gerd,
> 
> When compiling kernels from Alan's -ac tree, i.e. 2.4.8-ac5, and configuring
> CONFIG_SOUND_BT878=y, I completely lose the ability to play sound on my
> machine over my Emu10K1 soundcard.

No.  You are using the wrong device.  btaudio is a (recording only)
sound device, and it probably got /dev/dsp.  Try using /dev/dsp1, your
emu10k1 soundcard should listen there.

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
