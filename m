Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286786AbSABJGP>; Wed, 2 Jan 2002 04:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286815AbSABJF5>; Wed, 2 Jan 2002 04:05:57 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:54286 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S286786AbSABJFf>;
	Wed, 2 Jan 2002 04:05:35 -0500
From: Christer Weinigel <wingel@hog.ctrl-c.liu.se>
To: alan@lxorguk.ukuu.org.uk
Cc: hpa@zytor.com, robert@schwebel.de, linux-kernel@vger.kernel.org,
        jason@mugwump.taiga.com, anders@alarsen.net, rkaiser@sysgo.de
In-Reply-To: <E16Lh1Z-0003Go-00@the-village.bc.nu> (message from Alan Cox on
	Wed, 2 Jan 2002 08:45:25 +0000 (GMT))
Subject: Re: [RFC] Embedded X86 systems Was: [PATCH][RFC] AMD Elan patch
Reply-To: wingel@t1.ctrl-c.liu.se
In-Reply-To: <E16Lh1Z-0003Go-00@the-village.bc.nu>
Message-Id: <20020102090532.BB2B236F9F@hog.ctrl-c.liu.se>
Date: Wed,  2 Jan 2002 10:05:32 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > There is the basic Cx5530 chipset, which could have support in the
> > Linux kernel (IDE, graphics and sound).
> 
> It already does. Has done for ages. The non SB emulation mode of the audio
> is not supported but that I don't think matters.

I think that only the Cx550 IDE stuff is in the main kernel though,
the Cx5530 audio is a separate patch.  Also, the PCI IDs have change
for the SCx200, so the IDE driver needs to be updated.  I have a patch
for this and it seems to work, but I want to test it a bit more first.

> In general if we want to support lots of weird crap then the ARM folks have
> a very nice model and a lot of weird crap to have developed their ideas
> against. Personal preference
> 
> 	Type of system	(PC, Embedded)
>
> then for PC leave as is, for embedded
> 	
> 	Board type (blah, blah , blah)
> 	Firmware (PC BIOS, LinuxBIOS, RedBoot)

Sounds good.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
