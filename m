Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317922AbSFNOYn>; Fri, 14 Jun 2002 10:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317923AbSFNOYm>; Fri, 14 Jun 2002 10:24:42 -0400
Received: from h24-71-173-70.ss.shawcable.net ([24.71.173.70]:38812 "EHLO
	valhalla.homelinux.org") by vger.kernel.org with ESMTP
	id <S317922AbSFNOYm>; Fri, 14 Jun 2002 10:24:42 -0400
Date: Fri, 14 Jun 2002 08:22:08 -0600 (CST)
From: "Jason C. Pion" <jpion@valhalla.homelinux.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Nick Evgeniev <nick@octet.spb.ru>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <Pine.LNX.3.96.1020614082716.9892C-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0206140745001.15871-100000@valhalla.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2002, Bill Davidsen wrote:

> Clearly *any* problem which only happens with SMP isn't as wide-spread,
> and if you are running uni then there should not be a problem. Given that

This system is a Tyan S2460 with 2 AMD 1600+ processors.  I am not booting 
with the "noapic" option.  (Haven't needed to)  The Promise Ultra133TX2 
(20269) runs very happily with the AMD7411 that is on the mobo.  The 
Promise BIOS recognizes both attached drives as UDMA(133) and the kernel 
sets them up and uses them properly.  I do not need to do anything special 
at boot time either.  It just works!

> earlier and later similar chipset have a sticky bit and no problem, I
> think it would be reasonable to protect people in a stable kernel. If the
> config file needed to be patched and there were a warning on the next
> line, that would certainly assure they knew they were taking a risk.

I agree that some kind of warning (maybe the "EXPERIMENTAL" note in 
menuconfig) is appropriate for drivers that have known issues with certain 
pieces of hardware.  However, I can not condone pulling the driver from 
the kernel.  If it is working perfectly for some people, we would be 
penalizing them.

Later,
	Jason

