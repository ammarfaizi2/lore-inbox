Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277989AbRJIVhE>; Tue, 9 Oct 2001 17:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277991AbRJIVgx>; Tue, 9 Oct 2001 17:36:53 -0400
Received: from anime.net ([63.172.78.150]:57106 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S277989AbRJIVgk>;
	Tue, 9 Oct 2001 17:36:40 -0400
Date: Tue, 9 Oct 2001 14:37:08 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: German Gomez Garcia <german@piraos.com>
cc: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the 760MP
In-Reply-To: <Pine.LNX.4.33.0110092330230.434-100000@hal9000.piraos.com>
Message-ID: <Pine.LNX.4.30.0110091435540.17874-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, German Gomez Garcia wrote:
> On Tue, 9 Oct 2001, Dan Hollis wrote:
> > On Tue, 9 Oct 2001, German Gomez Garcia wrote:
> > > it appears in the /proc/cmdline that message stills apears.
> > > Also I'm unable to get correct readings with lm_sensors (CVS), I've been
> > > enable to detect the w83781d chip using the i2c-amd756 SMbus but half of
> > > the times the kernel hangs up when loading this module.
> > 1) You need to enable ACPI in bios for sensors to work.
> 	What about the kernel? must I enable it there too?

No. You don't need it in kernel.

> > 2) There's a bug in w83781d driver which causes the hang:
> >    http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=670
> >    The fix described at the bottom does work for me.
> 	Yes, it also works for me, now I can load the w83781d and I get
> the wrong results, the same that I get if I use motherboard monitor
> under windows, so I suppose it has something to do with the Tiger MP
> itself.

The CPU temperatures use thermal diode of different type than the default,
you must change it through proc or sensors.conf. Also I believe there is a
temperature offset.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

