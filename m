Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbSJYClw>; Thu, 24 Oct 2002 22:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261186AbSJYClw>; Thu, 24 Oct 2002 22:41:52 -0400
Received: from ns.cinet.co.jp ([210.166.75.130]:59921 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S261177AbSJYClv>;
	Thu, 24 Oct 2002 22:41:51 -0400
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A30F@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Takashi Iwai '" <tiwai@suse.de>
Cc: "'LKML '" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHSET 22/25] add support for PC-9800 architecture (sound 
	alsa)
Date: Fri, 25 Oct 2002 11:47:55 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

-----Original Message-----
From: Takashi Iwai
To: Osamu Tomita
Cc: LKML
Sent: 2002/10/24 0:46
Subject: Re: [PATCHSET 22/25] add support for PC-9800 architecture (sound
alsa)

> the question is, whether cs4232 module works on PC9800, or not.
> i guess the control-port is not used on this card.  in such a case,
> you can deactivate the control-port via module option (or even add
> ifdef for the specific kernel config).
Test results on some PC-9800 (including not CS4232 chip),
snd-cs4232 driver works fine with snd_isapnp=0 snd_cport=-1 options.
Thanks for your advice.

Another problem, I'm tring to separate mpu401 driver for PC-9800.
To do this, I need to patch many files. So I think previus patch is
better than separated driver. How do you think?

Regards
Osamu Tomita

