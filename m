Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRLLNY7>; Wed, 12 Dec 2001 08:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280002AbRLLNYk>; Wed, 12 Dec 2001 08:24:40 -0500
Received: from server1.fla.matrix.com.br ([200.196.24.21]:19975 "EHLO
	server1.fla.matrix.com.br") by vger.kernel.org with ESMTP
	id <S279778AbRLLNYe>; Wed, 12 Dec 2001 08:24:34 -0500
Message-ID: <3C175A7C.6C532320@roadnet.com.br>
Date: Wed, 12 Dec 2001 11:24:12 -0200
From: "Marcelo ''Mosca'' de Paula Bezerra" <mosca@roadnet.com.br>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: pt-BR, en, pt
MIME-Version: 1.0
To: Rui Sousa <rui.p.m.sousa@clix.pt>
CC: Zlatko Calusic <zlatko.calusic@iskon.hr>,
        emu10k1-devel@opensource.creative.com, linux-kernel@vger.kernel.org
Subject: Re: emu10k1 - interrupt storm?
In-Reply-To: <Pine.LNX.4.33.0112121112450.2868-100000@sophia-sousar2.nice.mindspeed.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try running esd with the -as 10 options..
As the help says, it will disconnect the audio device after 10 seconds
of inactivity. It will at least help you with the interrupt load while
not using sound.

Rui Sousa wrote:
> 
> 
> If the sound device is open and playback is enabled the driver runs
> at "full speed" even if the output is just silence.
> 
> 
> Both I think... With some machines the hardware timer(used inside
> the emu10k1) seems to be running at wrong rate.
> 
> Rui Sousa
>
