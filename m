Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSAKA7J>; Thu, 10 Jan 2002 19:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289816AbSAKA6u>; Thu, 10 Jan 2002 19:58:50 -0500
Received: from host213-1-172-96.btinternet.com ([213.1.172.96]:25477 "EHLO
	x.nat") by vger.kernel.org with ESMTP id <S286521AbSAKA6k>;
	Thu, 10 Jan 2002 19:58:40 -0500
Date: Fri, 11 Jan 2002 00:59:35 +0000
From: acrimon.beet@gmx.co.uk
To: linux-kernel@vger.kernel.org
Subject: via sound acting very dodgy
Message-ID: <20020111005935.C5983@x.nat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any known problems with via82cxxx_audio.c in 2.4.17?

Yesterday when I tried to record from my sound card, my machine
locked up completely. It did the same thing when I tried again
after reboot.

Today I was careful not to try and record from the soundcard. But
after playing a couple of samples, playback went silent. The following
message started appearing repeatedly in /var/log/messages:

kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1198

At the moment I'm pretty much assuming I've got broken hardware, but
I'd be interested to know if there are any known problems with
the driver.

Thanks,

ABeet.
