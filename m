Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318251AbSHDTSf>; Sun, 4 Aug 2002 15:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318252AbSHDTSf>; Sun, 4 Aug 2002 15:18:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14608 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S318251AbSHDTSe>; Sun, 4 Aug 2002 15:18:34 -0400
Date: Sun, 4 Aug 2002 21:22:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.30 ACPI: fixing compilation
Message-ID: <20020804192210.GA31471@atrey.karlin.mff.cuni.cz>
References: <20020804185827.GA15828@elf.ucw.cz> <Pine.LNX.4.44.0208041315130.10270-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208041315130.10270-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This fixes compilation and is actually right since we can't get SMP
> > machine suspending, anyway.
> 
> Did we make sure that we won't suspend on smp? I can't see where that 
> happens.

It was broken before so I left it broken. Second CPU will probably
kill it fast enough not to corrupt data too badly.

Does anyone have S3-capable SMP system?

SWSUSP refuses to work on SMP.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
