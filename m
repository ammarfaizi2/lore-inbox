Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbTARHcv>; Sat, 18 Jan 2003 02:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTARHcv>; Sat, 18 Jan 2003 02:32:51 -0500
Received: from wall.ttu.ee ([193.40.254.238]:38413 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id <S263137AbTARHcu>;
	Sat, 18 Jan 2003 02:32:50 -0500
Date: Sat, 18 Jan 2003 09:41:49 +0200 (EET)
From: Siim Vahtre <siim@pld.ttu.ee>
To: <linux-kernel@vger.kernel.org>
Subject: Re: i810_audio problems
In-Reply-To: <1042856440.713.4.camel@chandler>
Message-ID: <Pine.SOL.4.31.0301180934500.14196-100000@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 2003, Matthew J. Fanto wrote:
>
> I'm having problems with the i810_audio driver and the ICH3 chipset.
>
> When playing audio, it skips VERY badly. After stopping the audio, I get
> the message:
> drain_dac, dma timeout?

I've also noticed similar problems. Sometimes when I reboot I end up
having no sound coming from the speakers at all and when I try to play
something then the player either hangs(mplayer) or starts to skip
seconds(mp3blaster) (0:00, 0:07, 0:21 ..etc)

Rebooting the computer sevelar times will eventually fix it. Reloading
the module doesn't seem to help, however.

2.4.{18;19;20} vanilla kernels all had that problem, now on 2.5.59 I
haven't noticed it (yet?).

