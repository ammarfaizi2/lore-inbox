Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbTARKHv>; Sat, 18 Jan 2003 05:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbTARKHv>; Sat, 18 Jan 2003 05:07:51 -0500
Received: from c185062.adsl.hansenet.de ([213.39.185.62]:28822 "EHLO
	router.local.rw-it.net") by vger.kernel.org with ESMTP
	id <S264625AbTARKHu>; Sat, 18 Jan 2003 05:07:50 -0500
Date: Sat, 18 Jan 2003 11:16:49 +0100
From: Robert Wruck <robert@rw-it.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Timer bug fix ported to 2.4.20
Message-ID: <20030118101648.GA14016@router.local.rw-it.net>
References: <20030116185653.GB5780@router.local.rw-it.net> <Pine.LNX.4.05.10301170945150.2751-100000@marina.lowendale.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.05.10301170945150.2751-100000@marina.lowendale.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I recently upgraded from 2.2.19 to 2.4.20 and noted that the via timer
> > bugfix has disappeared.
> > 
> > I'm not sure if this is a VIA problem, because it happens on my PIII
> > i440BX-based board, Gigabyte GA-6BXE, which does not seem to have any
> > chips made by VIA. (82443BX, 32371EB PIIX4, ITE 8671 SuperIO)
> 
> Different people have reported this check triggered on various hardware
> which doesn't have VIA686-anything.  In my case on both an old AcerNote
> and a Toshiba-1800.
> 

OK, it seems in my case it's triggered by the initialization of the X
"s3virge" driver (for my s3 virge/dx pci card).
It doesn't occur when using "vga" nor when switching ttys.
Starting X with s3virge seems to be the only way to trigger it on my
system.

i'm not very familiar with those problems, i only know that resetting the
timer keeps my system clock from going mad.


robert

