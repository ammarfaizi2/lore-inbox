Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752790AbWKCJ7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbWKCJ7J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 04:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbWKCJ7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 04:59:08 -0500
Received: from pm-mx9.mgn.net ([195.46.220.205]:36502 "EHLO pm-mx9.mgn.net")
	by vger.kernel.org with ESMTP id S1752790AbWKCJ7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 04:59:07 -0500
Date: Fri, 3 Nov 2006 10:38:50 +0100
From: Damien Wyart <damien.wyart@free.fr>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       James@superbug.demon.co.uk, Takashi Iwai <tiwai@suse.de>
Subject: Re: ALSA message with 2.6.19-rc4-mm2 (not -mm1)
Message-ID: <20061103093850.GA19478@localhost.localdomain>
References: <20061102102607.GA2176@localhost.localdomain> <20061102192607.GA13635@kroah.com> <878xitpkvy.fsf@brouette.noos.fr> <20061102222242.GA17744@kroah.com> <87lkmtf2bu.fsf@brouette.noos.fr> <20061103070819.GB2448@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061103070819.GB2448@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH <greg@kroah.com> [2006-11-02 23:08]: And the other files in
> that directory are also symlinks pointing to one directory below the
> card0 device (with the exception of the timer file), right?

Here is the full listing:

lrwxrwxrwx 1 root root 0 Nov  3 08:39 admmidi -> ../../devices/virtual/sound/admmidi
lrwxrwxrwx 1 root root 0 Nov  3 08:39 adsp -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/adsp
lrwxrwxrwx 1 root root 0 Nov  3 08:39 amidi -> ../../devices/virtual/sound/amidi
lrwxrwxrwx 1 root root 0 Nov  3 08:39 audio -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/audio
lrwxrwxrwx 1 root root 0 Nov  3 08:39 card0 -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0
lrwxrwxrwx 1 root root 0 Nov  3 08:39 controlC0 -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/controlC0
lrwxrwxrwx 1 root root 0 Nov  3 08:39 dmmidi -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/dmmidi
lrwxrwxrwx 1 root root 0 Nov  3 08:39 dsp -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/dsp
lrwxrwxrwx 1 root root 0 Nov  3 08:39 hwC0D0 -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/hwC0D0
lrwxrwxrwx 1 root root 0 Nov  3 08:39 hwC0D2 -> ../../devices/virtual/sound/hwC0D2
lrwxrwxrwx 1 root root 0 Nov  3 08:39 midi -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/midi
lrwxrwxrwx 1 root root 0 Nov  3 08:39 midiC0D0 -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/midiC0D0
lrwxrwxrwx 1 root root 0 Nov  3 08:39 midiC0D1 -> ../../devices/virtual/sound/midiC0D1
lrwxrwxrwx 1 root root 0 Nov  3 08:39 midiC0D2 -> ../../devices/virtual/sound/midiC0D2
lrwxrwxrwx 1 root root 0 Nov  3 08:39 mixer -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/mixer
lrwxrwxrwx 1 root root 0 Nov  3 08:39 pcmC0D0c -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/pcmC0D0c
lrwxrwxrwx 1 root root 0 Nov  3 08:39 pcmC0D0p -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/pcmC0D0p
lrwxrwxrwx 1 root root 0 Nov  3 08:39 pcmC0D1c -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/pcmC0D1c
lrwxrwxrwx 1 root root 0 Nov  3 08:39 pcmC0D2c -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/pcmC0D2c
lrwxrwxrwx 1 root root 0 Nov  3 08:39 pcmC0D2p -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/pcmC0D2p
lrwxrwxrwx 1 root root 0 Nov  3 08:39 pcmC0D3p -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0/pcmC0D3p
lrwxrwxrwx 1 root root 0 Nov  3 08:39 seq -> ../../devices/virtual/sound/seq
lrwxrwxrwx 1 root root 0 Nov  3 08:39 sequencer -> ../../devices/virtual/sound/sequencer
lrwxrwxrwx 1 root root 0 Nov  3 08:39 sequencer2 -> ../../devices/virtual/sound/sequencer2
lrwxrwxrwx 1 root root 0 Nov  3 08:39 timer -> ../../devices/virtual/sound/timer

-- 
Damien Wyart
