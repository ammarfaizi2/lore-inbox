Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280954AbRKOR2g>; Thu, 15 Nov 2001 12:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280957AbRKOR2W>; Thu, 15 Nov 2001 12:28:22 -0500
Received: from air-1.osdl.org ([65.201.151.5]:14487 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S280954AbRKOR1G>;
	Thu, 15 Nov 2001 12:27:06 -0500
Date: Thu, 15 Nov 2001 09:29:27 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Faux Pas III <fauxpas@temp123.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Maestro 2E vs. Power mgmt
In-Reply-To: <20011115120314.A11264@temp123.org>
Message-ID: <Pine.LNX.4.33.0111150926410.21985-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Nov 2001, Faux Pas III wrote:

> I have a Toshiba laptop system (dynabook 3380v) with integrated
> Maestro 2E sound.  This works fine and dandy when on AC power, but
> when on battery, the sound doesn't play properly... xmms and
> mpg123 show very slow (1/10 or so) progress through the file and
> the sound that results is a staticky approximation of the correct
> output.
>
> The device shares irq 11 with the i82365 cardbus bridge, the
> NeoMagic 256va AGP chipset and the uhci usb controller.  Driver output
> is thus:
>
> maestro: Configuring ESS Maestro 2E fount at IO 0xEE00 IRQ 11
> maestro:  subvendor id: 0x00011179
> maestro: PCI power management capability: 0x7622
> maestro: AC97 Codec detected: v: 0x83847609 caps: 0x6940 pwr: 0xf
> maestro: 1 channels configured.
> maestro: version 0.15 time 14:51:38 Nov 15 2001
>
> I've tried with the power management both off and on, and with
> apm off in the kernel altogether.  Tried kernels 2.4.{13,14,15-pre{2,3}}

Could you do a lspci -vv as root on that device both with AC and without?
(to see the dump of of the PM capabilities?).

Thanks,

	-pat

