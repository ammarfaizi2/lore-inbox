Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277812AbRJLTWd>; Fri, 12 Oct 2001 15:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277813AbRJLTWX>; Fri, 12 Oct 2001 15:22:23 -0400
Received: from cnxt10002.conexant.com ([198.62.10.2]:58008 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S277812AbRJLTWO>; Fri, 12 Oct 2001 15:22:14 -0400
Date: Fri, 12 Oct 2001 21:22:17 +0200 (CEST)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: "Udo A. Steinberg" <reality@delusion.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        <emu10k1-devel@opensource.creative.com>
Subject: Re: Linux 2.4.12-ac1
In-Reply-To: <3BC732BF.A3FD9574@delusion.de>
Message-ID: <Pine.LNX.4.33.0110122118460.3012-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Udo A. Steinberg wrote:

Looking at your original e-mail I see there is something else wrong:
you should have by default OGAIN and DIGITAL1 volume controls.

Are you loading the modules and only then starting the mixer application?
Exiting/restarting the mixer doesn't change anything?

Rui

> Rui Sousa wrote:
>
> > The PCM mixer channel is now controlled by dsp microcode, but by default
> > this is working when you load the driver.
> > What probably happened is that you loaded the bass/treble patches with
> > and old version of the emu-dspmgr tool and this messed up the PCM mixer
> > channel code.
>
> Not here. It makes no difference if I load the driver without doing any
> dsp tweaking or configure the dsp using the emu-tools. I get no pcm-channel
> either way.
>
> > Two things to try:
> > 1. Use the driver before loading any dsp microcode.
> > 2. Get the latest user space tools 0.9.2 from
>
> I have been using 0.9.2. Earlier versions worked up to 2.4.10-ac11.
>

