Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293245AbSBWWmn>; Sat, 23 Feb 2002 17:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293243AbSBWWme>; Sat, 23 Feb 2002 17:42:34 -0500
Received: from varenorn.icemark.net ([212.40.16.200]:4003 "EHLO
	varenorn.internal.icemark.net") by vger.kernel.org with ESMTP
	id <S293236AbSBWWmY>; Sat, 23 Feb 2002 17:42:24 -0500
Date: Sat, 23 Feb 2002 23:39:38 +0100 (CET)
From: Benedikt Heinen <beh@icemark.net>
X-X-Sender: beh@berenium.icemark.ch
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thomas Hood <jdthood@mail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17: oops in kapm-idled?   (on IBM Thinkpad A30P [2653-66U])
In-Reply-To: <E16eQAU-0003de-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202232337300.1435-100000@berenium.icemark.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I can't switch off all individual devices in the notebook, but if I
> > use the prism2 driver from linux-wlan.com, I can't get the full
> > performance out of it - but just something like ~20kb/s throughput
> > in ftp  (Win2K gets more than 500kb/s)...
> What happens if you use the in kernel pcmcia, and the in kernel prism
> chipset drivers ?

The in-kernel prism driver doesn't seem to work with the built-in
wireless lan. But - from what I understand from the Configure.help,
this is what I'd expect - to me it looks like, linux will support
prism2 in either PCMCIA or PLX.
>From the linux-wlan-ng driver, I need to compile "Prism2.5 native
PCI" to get a driver that will recognize the card...


    Benedikt

  BEAUTY, n.  The power by which a woman charms a lover and terrifies a
    husband.
			(Ambrose Bierce, The Devil's Dictionary)

