Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbRFNIpD>; Thu, 14 Jun 2001 04:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbRFNIox>; Thu, 14 Jun 2001 04:44:53 -0400
Received: from Expansa.sns.it ([192.167.206.189]:518 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S261684AbRFNIom>;
	Thu, 14 Jun 2001 04:44:42 -0400
Date: Thu, 14 Jun 2001 10:44:31 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Daniel <ddickman@nyc.rr.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Message-ID: <Pine.LNX.4.33.0106141035340.27628-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Jun 2001, Daniel wrote:

> So without further ado here're the features I want to get rid of:
>
> i386, i486
> The Pentium processor has been around since 1995. Support for these older
> processors should go so we can focus on optimizations for the pentium and
> better processors.
Please, I have a lot of 486 that I use for many secondary things and a
386, why I should not be able to run the latest kernel on them?
In princip, linux have to support all old hardware out there.
>
> math-emu
> If support for i386 and i486 is going away, then so should math emulation.
> Every intel processor since the 486DX has an FPU unit built in. In fact
> shouldn't FPU support be a userspace responsibility anyway?
see previuos
>
> ISA, MCA, EISA device drivers
> If support for the buses is gone, there's no point in supporting devices for
> these buses.
Again, a lot of modern MB comes out with at less one isa slot, and anyway
isa bus is present also without the slot on all MB since it has to be
there. how many users are happy
with their old sound blaster 16 on ISA, or with their old
isa modem and would never change it? they should never be forced.
>
> MFM/RLL/XT/ESDI hard drive support
> Does anyone still *have* an RLL drive that works? At the very least get rid
> of the old driver (eg CONFIG_BLK_DEV_HD_ONLY, CONFIG_BLK_DEV_HD_IDE,
> CONFIG_BLK_DEV_XD, CONFIG_BLK_DEV_PS2)
see previous
>
> parallel/serial/game ports
> More controversial to remove this, since they are *still* in pretty wide
> use -- but USB and IEEE 1394 are the way to go. No ifs ands or buts.
see previous
>
> a.out
> Who needs it anymore. I love ELF.
and how many are happy to play doom with a.out svgalibs??
>
my 2 cents
Luigi


