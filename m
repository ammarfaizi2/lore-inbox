Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUHDQFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUHDQFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUHDQFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:05:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62879 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267330AbUHDQEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:04:08 -0400
Date: Wed, 4 Aug 2004 18:04:04 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lspci and ROM on bridge, was: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040804160404.GB32765@atrey.karlin.mff.cuni.cz>
References: <20040803213921.GA4585@ucw.cz> <20040804060001.52370.qmail@web14923.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040804060001.52370.qmail@web14923.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> lspci shows my AGP bridge
> 
> 00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev
> 02) (prog-if 00 [Normal decode])
>         Flags: bus master, 66Mhz, fast devsel, latency 64
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: fe900000-feafffff
>         Prefetchable memory behind bridge: f0000000-f7ffffff
>         Expansion ROM at 0000d000 [disabled] [size=4K]
>  
> It shows an expansion ROM at d000. d000 is a normal address for a ROM.
> But d000 also shows as I/O behind bridge.

Was it with the `-b' option or not?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"#define QUESTION ((bb) || !(bb))"  -- Shakespeare
