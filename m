Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSIHWGJ>; Sun, 8 Sep 2002 18:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSIHWGJ>; Sun, 8 Sep 2002 18:06:09 -0400
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:10392 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S315437AbSIHWGJ>; Sun, 8 Sep 2002 18:06:09 -0400
Date: Sun, 8 Sep 2002 18:18:31 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Adam Jaskiewicz <adamjaskie@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Western Digital hard drive and DMA
In-Reply-To: <02090817210208.00459@aragorn>
Message-ID: <Pine.LNX.4.33.0209081814480.27671-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hdd is running though ide-scsi, as it is a cd-rw. hda and hdb both have dma 
> turned off later in the boot process by hdparm. Could it be that I wasnt 
> using those 80 conductor cables, and was getting crosstalk? I guess i could 
> buy some to test that theory out...

if you have noisy cables and someone turns off udma,
yes, you could certainly see corruption.  if you can
possibly ever use udma, it's a very good idea to do so;
only with it are transfers checksummed.  80-conductor 
cables are always advantageous as well, though only 
required over udma33.  (remember that valid IDE cables 
are always <= 18" long, with no stubs...)

