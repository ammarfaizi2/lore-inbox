Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVKJWHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVKJWHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 17:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVKJWHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 17:07:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3818 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932074AbVKJWHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 17:07:37 -0500
Date: Thu, 10 Nov 2005 23:06:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: David Vrabel <dvrabel@cantab.net>, linux-mtd@lists.infradead.org,
       David Woodhouse <dwmw2@infradead.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051110220639.GB9905@elf.ucw.cz>
References: <1131616948.27347.174.camel@baythorne.infradead.org> <20051110103823.GB2401@elf.ucw.cz> <1131619903.27347.177.camel@baythorne.infradead.org> <20051110105954.GE2401@elf.ucw.cz> <1131621090.27347.184.camel@baythorne.infradead.org> <20051110120708.GG2401@elf.ucw.cz> <437344E0.9040502@cantab.net> <20051110130930.GJ2401@elf.ucw.cz> <1131644476.24595.18.camel@localhost.localdomain> <1131646197.23410.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131646197.23410.27.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Shouldn't you get hold of the datasheet for the flash chips and fill in
> > > > this information correctly?
> > > 
> > > I already have working sharp.c driver... And I do not even know
> > > manufacturer of the chip, just its ids.
> > 
> > The chip number is LF28F640BX which is a 64MBit device so perhaps Intel
> > StrataFlash 28F640? That seems to be a fairly common chip...
> 
> Some further research suggests it should perhaps be LH28F640BX which is
> a 48 pin Sharp flash chip (much more likely). The nearest datasheet I
> can find is:
> 
> http://www.datasheetarchive.com/semiconductors/download.php?Datasheet=1120647

That's strange; first the datasheet is pretty much useless; it does
not even give you product ID ("refer to documentation"). Then it
claims this device supports CFI. I guess it is easier to get the
values from sharp.c than from this datasheet :-(.

[It seems like the chip has many "options", and it is up to user how
it uses the chip.]
							Pavel
-- 
Thanks, Sharp!
