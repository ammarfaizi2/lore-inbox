Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbSAHK3n>; Tue, 8 Jan 2002 05:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285618AbSAHK3X>; Tue, 8 Jan 2002 05:29:23 -0500
Received: from smtp1.libero.it ([193.70.192.51]:30659 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S285589AbSAHK3R>;
	Tue, 8 Jan 2002 05:29:17 -0500
Message-ID: <3C3AC9B9.B854859D@alsa-project.org>
Date: Tue, 08 Jan 2002 11:28:09 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en, it
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jaroslav Kysela <perex@suse.cz>,
        "J.A. Magallon" <jamagallon@able.es>, Alan Cox <alan@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@ns.caldera.de>, sound-hackers@zabbo.net,
        linux-sound@vger.rutgers.edu, linux-kernel@vger.kernel.org
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <20020108102833.A2927@werewolf.able.es>
		<20020108103046.A3545@werewolf.able.es>
		<3C3AC150.BE4FFAFE@alsa-project.org> <s5hk7utgnh3.wl@alsa1.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> 
> At Tue, 08 Jan 2002 10:52:16 +0100,
> Abramo wrote:
> >
> >
> > So we'd have:
> > sound/
> > sound/oss_native
> > sound/oss_emul
> > sound/synth
> > sound/include
> > drivers/sound/i2c
> > drivers/sound/isa
> > drivers/sound/pci
> > drivers/sound/ppc
> 
> On the list above, to where OSS (hw specific) codes come?  Into a
> single directory, sound/oss_native?

Yes

> Or both ALSA and OSS drivers are
> mixed into drivers/sound/*?
> I'd like to see ALSA and OSS codes are separated into different
> directories...  Otherwise it's too confusing.

I think that in this way they are separated enough. Do you agree?

> 
> And how about drivers/sound/generic for generic hardware codes such as
> ac97_codec.c?

Currently Jaroslav has put that in alsa-kernel/pci/ac97. If we follow
this guideline they go in drivers/pci/ac97 (although I'm not sure
whether ac97 is PCI only).

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
