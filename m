Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284929AbRLUSDp>; Fri, 21 Dec 2001 13:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284934AbRLUSDZ>; Fri, 21 Dec 2001 13:03:25 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:25984 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S284929AbRLUSDT>; Fri, 21 Dec 2001 13:03:19 -0500
Date: Fri, 21 Dec 2001 13:03:36 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with ATA hard disk(s)
In-Reply-To: <20011221173533.C66C87A102@isis.telemach.net>
Message-ID: <Pine.LNX.4.33.0112211259570.1091-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am a beginner when it comes to Linux, so please bear with me.

please read the FAQ.

> When I look at the HDD settings after boot, I see that almost everything is 
> turned off:

I'm guessing you've failed to set the relevant ide-related CONFIG_
settings.  you definitely want the piix driver, and almost certainly
also all the yes-really-use-dma-by-default ones.

> messages:Dec 21 16:21:27 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
> DriveStatusError BadCRC }

http://www.tux.org/lkml/#s13-3

