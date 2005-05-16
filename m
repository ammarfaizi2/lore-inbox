Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVEPLTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVEPLTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 07:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVEPLTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 07:19:11 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:27038 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261523AbVEPLTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 07:19:04 -0400
Date: Mon, 16 May 2005 13:18:59 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
Message-ID: <20050516111859.GB13387@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050515145241.GA5627@irc.pl> <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net> <Pine.LNX.4.58.0505151809240.26531@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505151809240.26531@artax.karlin.mff.cuni.cz>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 May 2005, Mikulas Patocka wrote:

> Note that disk can still ignore FLUSH CACHE command cached data are small
> enough to be written on power loss, so small FLUSH CACHE time doesn't
> prove disk cheating.

Have you seen a drive yet that writes back blocks after power loss?

I have heard rumors about this, but all OEM manuals I looked at for
drives I bought or recommended simply stated that the block currently
being written at power loss can become damaged (with write cache off),
and that the drive can lose the full write cache at power loss (with
write cache on) so this looks like daydreaming manifested as rumor.

I've heard that drives would be taking rotational energy from their
rotating platters and such, but never heard how the hardware compensates
the dilation with decreasing rotational frequency, which also requires
changed filter settings for the write channel, block encoding, delays,
possibly stepping the heads and so on. I don't believe these stories
until I see evidence.

These are corner cases that a vendor would hardly optimize for.
If you know a disk drive (not battery-backed disk controller!) that
flashes its cache to NVRAM, or uses rotational energy to save its cache
on the platters, please name brand and model and where I can download
the material that documents this behavior.
