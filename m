Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310255AbSCAIGU>; Fri, 1 Mar 2002 03:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310389AbSCAIEU>; Fri, 1 Mar 2002 03:04:20 -0500
Received: from stargazer.compendium-tech.com ([64.156.208.76]:29122 "EHLO
	stargazer.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S310385AbSCAIED>; Fri, 1 Mar 2002 03:04:03 -0500
Date: Fri, 1 Mar 2002 00:03:01 -0800 (PST)
From: Kelsey Hudson <khudson@compendium-tech.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: texas <texas@ludd.luth.se>, <linux-kernel@vger.kernel.org>
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
In-Reply-To: <E16gbXt-0001s7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202282353370.18512-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Alan Cox wrote:

> > Tried 2.2 again thinking it might work now with the fixed BIOS settings
> > but no, still getting the "Keyboard: Timeout - AT keyboard not present?"
> > and "hda: lost interrupt" messages. So I can't even boot 2.2 and I have no
> 
> I guess that box is always assuming PnP or ACPI setup in which case 2.2
> will never work on it.

hmm. I guess this begs the question, is ACPI 100% working and stable now? 
I've got a similar problem with add-in IDE controllers which add more than 
8 IDE devices -- the 9th and higher devices are inaccessable with the same 
"hd?: lost interrupt" messages (beginning with hdi). The machine in 
question is a dual AthlonXP/MP 1900+ on that new Tyan S2466 mainboard. I 
figured it was a BIOS issue, but if the BIOS demands that ACPI configure 
stuff, then perhaps enabling ACPI is the key. I just wihs that BIOS 
manufacturers would get a fucking clue and realize that not all of us are 
going to be running that other ACPI-dependent OS on the board, and make a 
BIOS that configures devices the old-fashioned way: doing the work itself.

Tyan also needs to realize that assigning the same address to two sensors 
on the I2C bus just isn't a good idea...

Hopefully this fixes my problem. Thanks for the pointer! ;)

 Kelsey Hudson                                           khudson@ctica.com 
 Associate Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     
==== 0100101101001001010000110100101100100000010010010101010000100001 =====


