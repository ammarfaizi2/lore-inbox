Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289218AbSAGOdK>; Mon, 7 Jan 2002 09:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289219AbSAGOcw>; Mon, 7 Jan 2002 09:32:52 -0500
Received: from ns.caldera.de ([212.34.180.1]:8900 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S289218AbSAGOcq>;
	Mon, 7 Jan 2002 09:32:46 -0500
Date: Mon, 7 Jan 2002 15:32:18 +0100
Message-Id: <200201071432.g07EWI802933@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: perex@suse.cz (Jaroslav Kysela)
Cc: sound-hackers@zabbo.net, linux-sound@vger.rutgers.edu,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: ALSA patch for 2.5.2pre9 kernel
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.31.0201061814580.545-100000@pnote.perex-int.cz>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.31.0201061814580.545-100000@pnote.perex-int.cz> you wrote:
> The latest patch is alsa-2002-01-06-1-linux-2.5.2pre9.patch.gz and
> contains:

> * moved linux/drivers/sound directory to linux/sound/oss
> * moved sound core files to linux/sound
> * integrated ALSA kernel code
>   - linux/include/sound - sound header files
>   - linux/sound/core	- midlevel (no hw dependent) code
>   - linux/sound/drivers - generic drivers (no arch dependent)
>   - linux/sound/i2c     - reduced I2C core and drivers
>   - linux/sound/isa	- ISA sound hardware drivers
>   - linux/sound/pci	- PCI sound hardware drivers
>   - linux/sound/ppc	- PowerPC sound hardware drivers
>   - linux/sound/synth	- generic synthesizer support code

> We appreciate any comments regarding directory structure

linux/sound is silly.  It's drivers so put it under linux/drivers/sound.
Everything else seems to be sane to me.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
