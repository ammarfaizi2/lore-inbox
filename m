Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbUBWWTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbUBWWTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:19:11 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:46865 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262083AbUBWWSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:18:11 -0500
Date: Mon, 23 Feb 2004 22:18:06 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: fbdv/fbcon pending problems
In-Reply-To: <20040223203528.E433@Marvin.DL8BCU.ampr.org>
Message-ID: <Pine.LNX.4.44.0402232217020.11599-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Question: Is fbdev supposed to work without BIOS? 

It depends on the driver. Unfortunely most hardware companies will not 
give you info on how to boot a card BIOS-less :-( I do have code for the 
XL ati card to boot BIOS-less but it needs some work.


> 
> I have an ATI Technologies Inc 3D Rage Pro 215GP in an Alpha AXPpci33,
> currently running with MILO as firmware/bootloader. 
> For several reasons I want to change to the original SRM firmware. 
> Unfortunately its intel_cpu/BIOS emulation locks up on the ATI BIOS. With
> the BIOS disabled the SRM succeeds loading the kernel. fbdev seems to
> initialize _something_, i.e. the monitor wakes up ans displays a stable
> repeating pattern of vertical stripes. But it hangs the machine after
> these lines on serial console:
> 
> fb0: ATY Mach64 frame buffer device on PCI
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> 
> Booting the same kernel image (2.6.[13]) with MILO (which has a different
> cpu emulation that succeeds executing the BIOS) works fine with fbdev. 
> 
> Bye,
> Thorsten
> 
> 

