Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270117AbTGPEgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 00:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270120AbTGPEgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 00:36:03 -0400
Received: from [203.199.140.162] ([203.199.140.162]:14607 "EHLO
	calvin.codito.com") by vger.kernel.org with ESMTP id S270117AbTGPEgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 00:36:00 -0400
From: Amit Shah <shahamit@gmx.net>
To: Takashi Iwai <tiwai@suse.de>, Chris Meadors <twrchris@hereintown.net>
Subject: Re: 2.6.0-test1: ALSA problem
Date: Wed, 16 Jul 2003 10:20:32 +0530
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307151048.17586.shahamit@gmx.net> <1058281075.8444.7.camel@clubneon.priv.hereintown.net> <s5h7k6j3jvk.wl@alsa2.suse.de>
In-Reply-To: <s5h7k6j3jvk.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307161020.32377.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 Jul 2003 20:41, Takashi Iwai wrote:
> At 15 Jul 2003 10:57:55 -0400,
>
> Chris Meadors wrote:
> > On Tue, 2003-07-15 at 01:18, Amit Shah wrote:
> > > I don't know what the problem is exactly, since alsa shows it found
> > > one card... I'm using debian woody with alsa-base installed. Even if
> > > alsa shows one card detected, it doesn't play. (It doesn't recognize
> > > /dev/dsp?)
> > >
> > >
> > > Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09
> > > 12:01:18 2003 UTC).
> > > kobject_register failed for Ensoniq AudioPCI (-17)
> > > Call Trace:
> > >  [<c01f6b8a>] kobject_register+0x32/0x48
> > >  [<c0248a1b>] bus_add_driver+0x3f/0xa0
> > >  [<c0248e0a>] driver_register+0x36/0x3c
> > >  [<c01fb236>] pci_register_driver+0x6a/0x90
> > >  [<c04117ba>] alsa_card_ens137x_init+0xe/0x3c
> > >  [<c03f86f5>] do_initcalls+0x39/0x94
> > >  [<c03f876c>] do_basic_setup+0x1c/0x20
> > >  [<c010509b>] init+0x33/0x188
> > >  [<c0105068>] init+0x0/0x188
> > >  [<c0107145>] kernel_thread_helper+0x5/0xc
> > >
> > > ALSA device list:
> > >   #0: Intel 82801BA-ICH2 at 0xe800, irq 17
> >
> > I see exactly the same thing with my Sound Blaster 16 PCI.
>
> hmm, something gets wrong when no irq is generated and the pcm stream
> is forced to be closed.  i'll check this.
>
> are you using a UP kernel or an SMP kernel?

It's a UP Pentium IV kernel.

-- 
Amit Shah
http://amitshah.nav.to/

Why do you want to read your code?
 The machine will.
                 -- Sunil Beta

