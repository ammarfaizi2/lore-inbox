Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277323AbRJEHDD>; Fri, 5 Oct 2001 03:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277324AbRJEHCw>; Fri, 5 Oct 2001 03:02:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52498 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277323AbRJEHCj>; Fri, 5 Oct 2001 03:02:39 -0400
Date: Fri, 5 Oct 2001 09:03:07 +0200
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Sound artifacts in Gravis Ultrasound
Message-ID: <20011005090307.A16202@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Gravis Ultrasound sound card. I suspect kernel from non-continuous feed of audio
data into the device.

When I feed directly a sine-wave data into /dev/dsp, 100Hz, 1KHz, 10kHz, there is
a distortion that can be heard on 1kHz, is not heard on 100Hz and is very strong at 10kHz.
It sounds like every several-per-second to several-ten-per-second, the data in the sound
card are repeated (for several samples). The distortion occurs permanently and generates
a regular sound, something like a car ignition system makes in board radio.

When I play mp3 (mpg123) or Ogg Vorbis (ogg123), it can be heard also, when suitable
pattern is present in the music to make the distortion audible.

It is not caused by my amplifier (audible also in earphones), not caused by too
much volume (when playing on low volume, it is also there, it's a linear phenomenon).
The sound of distortion is also not added to the signal, because can not be heard
when certain sound patterns appear in the music.

Is there any kernel setting that improves continuity of data feed? The card is
Gravis Ultrasound Plug'n'play, on ISA.

Clock

