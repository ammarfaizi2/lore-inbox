Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268114AbTAJCmE>; Thu, 9 Jan 2003 21:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268116AbTAJCmE>; Thu, 9 Jan 2003 21:42:04 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36060 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268114AbTAJCmD>; Thu, 9 Jan 2003 21:42:03 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200301100250.h0A2olE20795@devserv.devel.redhat.com>
Subject: Re: 2.4.19 -- ac97_codec failure ALi 5451
To: cogwepeter@greenie.frogspace.net (Peter)
Date: Thu, 9 Jan 2003 21:50:47 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com (Alan Cox)
In-Reply-To: <Pine.LNX.4.44.0301090206290.30969-100000@greenie.frogspace.net> from "Peter" at Jan 09, 2003 06:35:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, 
> 		version 0.14.9d, 00:57:19 Jan  9 2003
>         PCI: Enabling device 00:06.0 (0000 -> 0003)
>         PCI: Assigned IRQ 10 for device 00:06.0
>         trident: ALi Audio Accelerator found at IO 0x1000, IRQ 10
>         ac97_codec: AC97 Audio codec, id: 0x4144:0x5372 (Unknown)

So far so good.

>         ali: AC97 CODEC read timed out.
>         last message repeated 127 times
>         ali: AC97 CODEC write timed out.
>         ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)

Something lost the codec. Could be power management - was the laptop
suspended before it went funny ?

Alan
