Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbUAUSGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266024AbUAUSGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:06:24 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:4533 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S266021AbUAUSGW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:06:22 -0500
Date: Wed, 21 Jan 2004 10:06:05 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dale Weber <linuxgeek@thedynaplex.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA vs. OSS
Message-ID: <20040121180605.GK23765@srv-lnx2600.matchmail.com>
Mail-Followup-To: Dale Weber <linuxgeek@thedynaplex.net>,
	linux-kernel@vger.kernel.org
References: <1074532714.16759.4.camel@midux> <200401201046.24172.hus@design-d.de> <1074625238.400d7ad6144e9@horde.sandall.us> <200401210303.24009.linuxgeek@thedynaplex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401210303.24009.linuxgeek@thedynaplex.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 03:03:24AM -0800, Dale Weber wrote:
> On Tuesday 20 January 2004 11:00, Eric Sandall wrote:
> > Quoting Heinz Ulrich Stille <hus@design-d.de>:
> > > On Monday 19 January 2004 19:21, Travis Morgan wrote:
> > > > I have a soundblaster Live Value card. I can no longer control the
> > >
> > > I also have a SB Live!, and it doesn't work with ALSA at all - the AC97
> > > codec doesn't load. I haven't taken the time to track it down as it does
> > > work just fine with OSS (under SMP at that).
> >
> > My SBLive! has been working with ALSA since I first used it (0.9.6 or
> > something) on both 2.4 and 2.6 kernels.
> 
> 	My SBLive! 5.1 card has always worked great with ALSA (kernels 2.4 and now 
> 2.6), and I started using ALSA at about v9.0 (I think).  It's on an A-Bit 
> KR7A-RAID board now.
> 

I have an Intel 8x0 that doesn't work with the alsa driver, but the OSS
driver works perfectly.  I can load the alsa driver, and get interrupts from
the card (built-in on the MB), but no sound comes out, and I tried changing
the volume in alsamixer with no results except for hearing static when I
unmuted the headphone output.

I'm using 2.6.1, and I've never used alsa in 2.4.

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 05)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 05)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra TF
02:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
02:0a.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
