Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280016AbRKDQF3>; Sun, 4 Nov 2001 11:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280022AbRKDQFT>; Sun, 4 Nov 2001 11:05:19 -0500
Received: from [24.131.196.222] ([24.131.196.222]:53256 "EHLO
	moonweaver.awesomeplay.com") by vger.kernel.org with ESMTP
	id <S280019AbRKDQE6>; Sun, 4 Nov 2001 11:04:58 -0500
Subject: Re: Via Onboard Audio - Round #2
From: Sean Middleditch <elanthis@awesomeplay.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BE54731.FC9437CE@mandrakesoft.com>
In-Reply-To: <1004849558.457.15.camel@stargrazer> 
	<3BE4CC20.5FFEC4B5@mandrakesoft.com> <1004851818.457.24.camel@stargrazer> 
	<3BE54731.FC9437CE@mandrakesoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100 (Preview Release)
Date: 04 Nov 2001 11:09:13 -0500
Message-Id: <1004890153.469.2.camel@stargrazer>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-04 at 08:48, Jeff Garzik wrote:
> Sean Middleditch wrote:
> > drivers can handle it.  This is a limitation and/or problem with Linux
> > and it's Via Audio driver.  How can I get around this, or do I need to
> > reinstall WindowsXP to use the audio?
> 
> This has absolutely nothing to do with the audio driver.
> 
> Linux is having trouble with your PCI IRQ routing table that is
> presented by your BIOS to Linux.
> 
> Can you provide 'dmesg -s 16384' output, after changing line 7 of
> arch/i386/kernel/pci-i386.h thusly:
> -#undef DEBUG
> +#define DEBUG 1
> 
> This will show me your PCI IRQ routing table.

That I will do when I get the chance (hopefully soon).

> 
> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
> 


