Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277271AbRJLSNM>; Fri, 12 Oct 2001 14:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276698AbRJLSND>; Fri, 12 Oct 2001 14:13:03 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:50437 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S276463AbRJLSMx>; Fri, 12 Oct 2001 14:12:53 -0400
Message-ID: <3BC732BF.A3FD9574@delusion.de>
Date: Fri, 12 Oct 2001 20:13:19 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.12-ac1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rui Sousa <rui.p.m.sousa@clix.pt>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        emu10k1-devel@opensource.creative.com
Subject: Re: Linux 2.4.12-ac1
In-Reply-To: <Pine.LNX.4.33.0110122000500.3012-100000@sophia-sousar2.nice.mindspeed.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Sousa wrote:

> The PCM mixer channel is now controlled by dsp microcode, but by default
> this is working when you load the driver.
> What probably happened is that you loaded the bass/treble patches with
> and old version of the emu-dspmgr tool and this messed up the PCM mixer
> channel code.

Not here. It makes no difference if I load the driver without doing any
dsp tweaking or configure the dsp using the emu-tools. I get no pcm-channel
either way.

> Two things to try:
> 1. Use the driver before loading any dsp microcode.
> 2. Get the latest user space tools 0.9.2 from

I have been using 0.9.2. Earlier versions worked up to 2.4.10-ac11.
