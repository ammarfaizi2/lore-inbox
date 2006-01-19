Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161379AbWASUYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161379AbWASUYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161412AbWASUYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:24:49 -0500
Received: from khc.piap.pl ([195.187.100.11]:59913 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1161379AbWASUYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:24:49 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: RFC: OSS driver removal, a slightly different approach
References: <20060119174600.GT19398@stusta.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 19 Jan 2006 21:24:44 +0100
In-Reply-To: <20060119174600.GT19398@stusta.de> (Adrian Bunk's message of "Thu, 19 Jan 2006 18:46:00 +0100")
Message-ID: <m3ek34vucz.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> 1. ALSA drivers for the same hardware 

[ a list of relatively modern cards, mostly PCI-based ]

> 2. ALSA drivers for the same hardware with known problems

[ same here ]


> 3. no ALSA drivers for the same hardware
>
> SOUND_ACI_MIXER

Never heard

> SOUND_ADLIB

IIRC 8-bit sound, ISA. GUS on DOS used to emulate it

> SOUND_AEDSP16

Never heard

> SOUND_AU1550_AC97

Never heard but ac97 suggests it's not that old

> SOUND_BCM_CS4297A
> SOUND_HAL2
> SOUND_IT8172
> SOUND_KAHLUA

Kahlua is a liquor in Mexico named after some ancient (Mayan or Aztec)
deity :-)

> SOUND_MSNDCLAS
> SOUND_MSNDPIN

Turtle Beach, I think it's newer than (at least the original) GUS.

> SOUND_PAS

Pro Audio Spectrum. Earlier than GUS? 8-bit I think

> SOUND_PSS
> SOUND_SB

The original one (8-bit)? Not sure about relation to Kahlua and PAS

> SOUND_SH_DAC_AUDIO
> SOUND_TRIX
> SOUND_VIDC
> SOUND_VRC5477
> SOUND_VWSND
> SOUND_WAVEARTIST

Look strange.


Don't you all think a large part (if not most) of the "ALSA-unsupported"
cards is no longed in any (Linux-related) use? I wouldn't be surprised
if they just don't exist anymore. Who is to write drivers for them and -
more importantly - who can test them?

The oldest card I currently have is (the original) GUS, it has 16-bit
DACs (and 8-bit ADC) and it's long dead (never bothered to fix it but
I think it could be easy). And I see it would be supported.

My oldest working (or at least installed) card is SB64 ISA, and it's
supported too. Yes, I have few junk-grade machines here.
-- 
Krzysztof Halasa
