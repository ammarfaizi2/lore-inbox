Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbTBOXKI>; Sat, 15 Feb 2003 18:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTBOXKI>; Sat, 15 Feb 2003 18:10:08 -0500
Received: from arava.co.il ([212.179.127.3]:38337 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S265382AbTBOXKH>;
	Sat, 15 Feb 2003 18:10:07 -0500
Date: Sun, 16 Feb 2003 01:22:31 +0200 (IST)
From: Matan Ziv-Av <matan@svgalib.org>
To: Jeff Mock <jeff@mock.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Vertical blanking interrupts
In-Reply-To: <5.1.0.14.2.20030215113708.01c398e0@ns.mock.com>
Message-ID: <Pine.LNX.4.21_heb2.09.0302160110170.3931-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Jeff Mock wrote:

> In particular, the platform is a VIA mini-ITX motherboard that uses
> a VIA PLE133 combined northbridge and Trident Cyberblade graphics
> controller.
> 
> VGAs have a legacy feature to generate a vertical blanking interrupt.
> I don't think windows or linux use this feature.
> 
> I'm having trouble getting the vertical blanking interrupt to work.I'm
> a bit out of my depth with this thing, so be gentle.

>From my experience, many video chipsets are not VGA compatible in
this regard. If you have documentation for your chipset, maybe using 
chipset specific code is preferable.

> Does anyone out there have experience getting VGA vertical blanking
> interrupts to work?Why would the VGA device not show up in the
> IRQ routing table?Is this a BIOS bug or are VGA interrupts just not
> supported by the hardware anymore?Any advice appreciated.

You can see code that implements vertical blanking interrupts in svgalib
(http://www.arava.co.il/matan/svgalib). This includes standard VGA, as
well support for a few chipsets. Unfortunately, it does not work on my
trident card.



-- 
Matan Ziv-Av.                         matan@svgalib.org


