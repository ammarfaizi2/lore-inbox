Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291263AbSAaUH5>; Thu, 31 Jan 2002 15:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291262AbSAaUHr>; Thu, 31 Jan 2002 15:07:47 -0500
Received: from www.transvirtual.com ([206.14.214.140]:8976 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291261AbSAaUHc>; Thu, 31 Jan 2002 15:07:32 -0500
Date: Thu, 31 Jan 2002 12:06:36 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Vojtech Pavlik <vojtech@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@oss.sgi.com,
        Linux ARM mailing list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: [PATCH] Migration to input api for keyboards
In-Reply-To: <20020131004041.K19292@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10201311159380.23385-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >    As some on you know the input api drivers for the PS/2 keyboard/mice
> > have gone into the dj tree for 2.5.X. I need people on other platforms
> > besides ix86 to test it out. I made the following patch that forces the
> > use of the new input drivers so people can test it. Shortly this patch
> > will be placed into the DJ tree but before I do this I want to make sure
> > it works for all platforms. Here is the patch to do this. Thank you.  
> 
> Oops.

Oops?

> Out of those 3 ARM machines, only 1 or maybe 2 has an 8042-compatible
> port.
> 
> CONFIG_PC_KEYB != i8042 controller present.  Please look more closely
> at stuff in include/asm-arm/arch-*/keyboard.h

I posted to find out which ones. BTW we have a driver for the acorn
keyboard controller. No acorn keyboard but we do have support the acorn
mouse. I can create a patch so you can give the mouse driver a try. Also
help on porting the acorn keyboard driver would be helpful, any docs on
it. 

