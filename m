Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272249AbRHWMt2>; Thu, 23 Aug 2001 08:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272250AbRHWMtS>; Thu, 23 Aug 2001 08:49:18 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:32664 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S272249AbRHWMtH>; Thu, 23 Aug 2001 08:49:07 -0400
Date: Thu, 23 Aug 2001 09:04:09 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@zip.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops after mounting ext3 on 2.4.8-ac9
In-Reply-To: <E15ZfMa-0002Il-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0108230857480.4431-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Alan Cox wrote:

> ac8 has further superblock updates, I wonder if those are what ticklets it.
>
> Can you try 2.4.8ac7 with the 2.4.8ac8 drivers/usb and include/linux/usb*
> changes ?

Okay I trimmed intermediate patch patch-2.4.8-ac7-ac8 down to just this:

patching file drivers/usb/CDCEther.c
patching file drivers/usb/Config.in
patching file drivers/usb/Makefile
patching file drivers/usb/catc.c
patching file drivers/usb/hp5300.c
patching file drivers/usb/hp5300.h
patching file drivers/usb/hpusbscsi.c
patching file drivers/usb/hpusbscsi.h
patching file drivers/usb/kaweth.c
patching file drivers/usb/pegasus.c
patching file drivers/usb/usb.c
patching file include/linux/usb.h

> If Im right it wont oops

Nope, it did oops.  Looks pretty much same too.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

