Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287896AbSAHFOl>; Tue, 8 Jan 2002 00:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287900AbSAHFO1>; Tue, 8 Jan 2002 00:14:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13319 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287899AbSAHFN7>; Tue, 8 Jan 2002 00:13:59 -0500
Date: Mon, 7 Jan 2002 21:12:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@redhat.com>
cc: "J.A. Magallon" <jamagallon@able.es>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@ns.caldera.de>, Jaroslav Kysela <perex@suse.cz>,
        <sound-hackers@zabbo.net>, <linux-sound@vger.rutgers.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <200201080201.g0821tT25111@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0201072111510.8010-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jan 2002, Alan Cox wrote:
> > Would't it be better to split drivers:
> >
> > sound/core.c
> > sound/alsa/alsa-core.c
> > sound/alsa/drivers/alsa-emu10k.c
> > sound/oss/oss-core.c
> > sound/oss/drivers/oss-emu10k.c
>
> Thats much harder to do randomg greps on and to find stuff,than drivers
> first

I agree. Put drivers separately, let's not split it up more than that.

		Linus

