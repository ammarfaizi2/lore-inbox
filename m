Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279557AbRJ2Vcr>; Mon, 29 Oct 2001 16:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279543AbRJ2Vcg>; Mon, 29 Oct 2001 16:32:36 -0500
Received: from iris.kkt.bme.hu ([152.66.114.49]:61714 "HELO iris.kkt.bme.hu")
	by vger.kernel.org with SMTP id <S279561AbRJ2VcU>;
	Mon, 29 Oct 2001 16:32:20 -0500
Date: Mon, 29 Oct 2001 22:32:55 +0100 (CET)
From: PALFFY Daniel <dpalffy@kkt.bme.hu>
To: Alex Deucher <agd5f@yahoo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: opl3sa2 sound driver and mixers
In-Reply-To: <E15yIWa-0003lV-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0110292228040.24547-100000@iris.kkt.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Alan Cox wrote:

> > What's strange is that 2 mixers seem to get loaded. 
> > The first is for a CS4??? (can't recall the exact
> 
> CS4232 - that mixer shouldnt be getting created. That is a bug. I'll take
> a look at it

Please read Documentation/sound/OPL3-SA2 (the two mixers are intentional,
some channels are available only on the MSS mixer, others only on the
OPL3-SA2), and don't break the driver! Since the latest DMA fix finally
everything works fine on my Portege 3010 (which is exactly the same as the
3020 except for a slower CPU and smaller disk).

--
Dani
			...and Linux for all.


