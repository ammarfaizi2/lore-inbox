Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283610AbRLEAO6>; Tue, 4 Dec 2001 19:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283611AbRLEAOt>; Tue, 4 Dec 2001 19:14:49 -0500
Received: from 216-21-153-9.ip.van.radiant.net ([216.21.153.9]:59656 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S283610AbRLEAOm>;
	Tue, 4 Dec 2001 19:14:42 -0500
Date: Tue, 4 Dec 2001 16:34:43 +0000 (/etc/localtime)
From: <gmack@innerfire.net>
To: Takashi Iwai <tiwai@suse.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [s-h] Re: OSS driver cleanups.
In-Reply-To: <s5hy9kinbaw.wl@alsa1.suse.de>
Message-ID: <Pine.LNX.4.21.0112041631180.4650-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is another issue, that alsa mutes all volumes as default.
> I know that's what sometime annoying people.  IMO, it's same on OSS
> anyway, since everyone needs to set up the mixer as he likes after
> start up.

That's not a bug that's a feature!

The drivers included in the 2.2.x and early 2.4.x series kernels(havn't
tested lately) cause a feedback loop on some laptops that continues until
the mixers are set.  (usually 1 to 2 seconds during bootup)  I'd *really*
prefer mute.  

	Gerhard
  

