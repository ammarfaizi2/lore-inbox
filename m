Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTHaXj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 19:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbTHaXj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 19:39:59 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:21436 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263060AbTHaXj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 19:39:58 -0400
Date: Mon, 1 Sep 2003 01:39:57 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Petr Baudis <pasky@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: IDE DMA breakage w/ 2.4.21+ and 2.6.0-test4(-mm4)
In-Reply-To: <20030831200639.GA573@pasky.ji.cz>
Message-ID: <Pine.LNX.4.44.0309010132440.19313-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did few more experiments, and one strange thing is that /proc/dma does not
> change when turning using_dma on thru hdparm:
>
>  1: SoundBlaster8
>  4: cascade
>
> I'd expect some entry for ide to appear or so. Or is this normal?

/proc/dma lists isa dma devices.
pci busmaster dma that is used by ide controllers has nothing to do with
it. It's totally different technology and it's reported in /proc/pci (look
for "Master Capable").

Mikulas

