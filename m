Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283340AbSAHKmz>; Tue, 8 Jan 2002 05:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285630AbSAHKmp>; Tue, 8 Jan 2002 05:42:45 -0500
Received: from gate.perex.cz ([194.212.165.105]:53769 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S283340AbSAHKmd>;
	Tue, 8 Jan 2002 05:42:33 -0500
Date: Tue, 8 Jan 2002 11:41:38 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        "J.A. Magallon" <jamagallon@able.es>, Alan Cox <alan@redhat.com>,
        Christoph Hellwig <hch@ns.caldera.de>,
        "sound-hackers@zabbo.net" <sound-hackers@zabbo.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <3C3AC9B9.B854859D@alsa-project.org>
Message-ID: <Pine.LNX.4.31.0201081137220.482-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Abramo Bagnara wrote:

> > And how about drivers/sound/generic for generic hardware codes such as
> > ac97_codec.c?
>
> Currently Jaroslav has put that in alsa-kernel/pci/ac97. If we follow
> this guideline they go in drivers/pci/ac97 (although I'm not sure
> whether ac97 is PCI only).

I've not seen using AC97 codec in other hardware than PCI based, but the
design of these codecs is independent on the bus bridge. Note that the
current directory structure is my proposal so it is possible to move ac97
sources to another directory.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org

