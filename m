Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277985AbRJIVcx>; Tue, 9 Oct 2001 17:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277986AbRJIVcn>; Tue, 9 Oct 2001 17:32:43 -0400
Received: from [213.97.184.209] ([213.97.184.209]:128 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S277985AbRJIVcY>;
	Tue, 9 Oct 2001 17:32:24 -0400
Date: Tue, 9 Oct 2001 23:32:28 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Dan Hollis <goemon@anime.net>
cc: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the 760MP
In-Reply-To: <Pine.LNX.4.30.0110091415270.17086-100000@anime.net>
Message-ID: <Pine.LNX.4.33.0110092330230.434-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Dan Hollis wrote:

> On Tue, 9 Oct 2001, German Gomez Garcia wrote:
> > it appears in the /proc/cmdline that message stills apears.
> > Also I'm unable to get correct readings with lm_sensors (CVS), I've been
> > enable to detect the w83781d chip using the i2c-amd756 SMbus but half of
> > the times the kernel hangs up when loading this module.
>
> 1) You need to enable ACPI in bios for sensors to work.

	What about the kernel? must I enable it there too?

> 2) There's a bug in w83781d driver which causes the hang:
>    http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=670
>    The fix described at the bottom does work for me.

	Yes, it also works for me, now I can load the w83781d and I get
the wrong results, the same that I get if I use motherboard monitor
under windows, so I suppose it has something to do with the Tiger MP
itself.

	-german

-------------------------------------------------------------------------
German Gomez Garcia          | Send email with "SEND GPG KEY" as subject
<german@piraos.com>          | to receive my GnuPG public key.

