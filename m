Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSLIKxb>; Mon, 9 Dec 2002 05:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSLIKxb>; Mon, 9 Dec 2002 05:53:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60680 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265099AbSLIKxa>; Mon, 9 Dec 2002 05:53:30 -0500
Date: Mon, 9 Dec 2002 12:01:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ducrot Bruno <poup@poupinou.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Message-ID: <20021209110111.GA18878@atrey.karlin.mff.cuni.cz>
References: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain> <20021206000618.GB15784@atrey.karlin.mff.cuni.cz> <20021206185702.GE17595@poup.poupinou.org> <20021208194944.GB19604@atrey.karlin.mff.cuni.cz> <20021209102858.GA14882@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021209102858.GA14882@poup.poupinou.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I think that s4bios is nice to have. Its similar to S3 and easier to
> > set up than swsusp... It would be nice to have it.
> 
> for me:
> pros:
> -----
> 1- it is really really more easier to implement than S4;
> 2- we can even have it with 2.4 kernels (it seems that it work without
> the need of freezing processes, but I suspect that this statement
> is 'wrong' by nature).
> 
> cons:
> -----
> 1- it is much slower (especially at save time) than your swsusp;
> 2- end users must setup their systems (need to create a suspend partition,
> or to keep a vfat partition as the really first one (/dev/hda1));
> 3- we use a bios function.  Actually, everything can happen...
> 
> That why I prefer swsusp at this time, or any other implementation of S4 (I
> think about an implementation of S4 via LKCD).

Yes I think swsusp is better (long term), but it might be worth it to
have S4bios, too. At least it has nice graphical task bars :-). Can
you push the patch, or is it okay for me to try to get it merged?

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
