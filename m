Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280944AbRKORDn>; Thu, 15 Nov 2001 12:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280945AbRKORDd>; Thu, 15 Nov 2001 12:03:33 -0500
Received: from dsl-65-185-241-169.telocity.com ([65.185.241.169]:12674 "HELO
	mail.temp123.org") by vger.kernel.org with SMTP id <S280944AbRKORDZ>;
	Thu, 15 Nov 2001 12:03:25 -0500
Date: Thu, 15 Nov 2001 12:03:14 -0500
From: Faux Pas III <fauxpas@temp123.org>
To: linux-kernel@vger.kernel.org
Subject: Maestro 2E vs. Power mgmt
Message-ID: <20011115120314.A11264@temp123.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Toshiba laptop system (dynabook 3380v) with integrated
Maestro 2E sound.  This works fine and dandy when on AC power, but
when on battery, the sound doesn't play properly... xmms and 
mpg123 show very slow (1/10 or so) progress through the file and
the sound that results is a staticky approximation of the correct
output.

The device shares irq 11 with the i82365 cardbus bridge, the
NeoMagic 256va AGP chipset and the uhci usb controller.  Driver output
is thus:

maestro: Configuring ESS Maestro 2E fount at IO 0xEE00 IRQ 11
maestro:  subvendor id: 0x00011179
maestro: PCI power management capability: 0x7622
maestro: AC97 Codec detected: v: 0x83847609 caps: 0x6940 pwr: 0xf
maestro: 1 channels configured.
maestro: version 0.15 time 14:51:38 Nov 15 2001

I've tried with the power management both off and on, and with 
apm off in the kernel altogether.  Tried kernels 2.4.{13,14,15-pre{2,3}}

-- 
Josh Litherland (fauxpas@temp123.org)
