Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277401AbRJEPAY>; Fri, 5 Oct 2001 11:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277404AbRJEPAO>; Fri, 5 Oct 2001 11:00:14 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:12552 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S277401AbRJEPAB>;
	Fri, 5 Oct 2001 11:00:01 -0400
Message-ID: <3BBDCC4C.EF9F7C49@tsc.uc3m.es>
Date: Fri, 05 Oct 2001 17:05:48 +0200
From: noreply@tsc.uc3m.es
X-Mailer: Mozilla 4.51 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Sound artifacts in Gravis Ultrasound
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a Gravis Ultrasound sound card. I suspect kernel from
> non-continuous feed of audio
> data into the device.
> 
> When I feed directly a sine-wave data into /dev/dsp, 100Hz, 1KHz, 10kHz,
> there is
> a distortion that can be heard on 1kHz, is not heard on 100Hz and is
> very strong at 10kHz.
> It sounds like every several-per-second to several-ten-per-second, the
> data in the sound
> card are repeated (for several samples). The distortion occurs
> permanently and generates
> a regular sound, something like a car ignition system makes in board
> radio.
> 
> When I play mp3 (mpg123) or Ogg Vorbis (ogg123), it can be heard also,
> when suitable
> pattern is present in the music to make the distortion audible.
> 
> It is not caused by my amplifier (audible also in earphones), not caused
> by too
> much volume (when playing on low volume, it is also there, it's a linear
> phenomenon).
> The sound of distortion is also not added to the signal, because can not
> be heard
> when certain sound patterns appear in the music.
> 
> Is there any kernel setting that improves continuity of data feed? The
> card is
> Gravis Ultrasound Plug'n'play, on ISA.

I have the exact same problems using a Sound Blaster 128 PCI with the
es1371.

It's a linux problem because it works with Windows 98.
