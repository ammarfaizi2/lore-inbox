Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSEOMY4>; Wed, 15 May 2002 08:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316391AbSEOMYz>; Wed, 15 May 2002 08:24:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50449 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316390AbSEOMYz>; Wed, 15 May 2002 08:24:55 -0400
Subject: Re: i810_audio support
To: alick@elvis.ru (Oleg Amiton)
Date: Wed, 15 May 2002 12:44:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020515061450.GB1250@elvis.ru> from "Oleg Amiton" at May 15, 2002 10:14:51 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177xCr-0001jK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> modprobe'ing of i810_audio.o and ac97_codec results here:
> 
> -- cut --
> i810: Intel ICH2 found at IO 0xe000 and 0xdc00, IRQ 9
> i810_audio: Audio Controller supports 6 channels.

It found you hae a 6 channel capable chipset

> ac97_codec: AC97 Audio codec, id: 0x8384:0x7600 (SigmaTel STAC????)
> i810_audio: only 48Khz playback available.
> i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2

With what appears to be a single stereo only fixed rate AC97 codec
