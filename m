Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSKXWoN>; Sun, 24 Nov 2002 17:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSKXWoN>; Sun, 24 Nov 2002 17:44:13 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19975 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261859AbSKXWoM>; Sun, 24 Nov 2002 17:44:12 -0500
Date: Sun, 24 Nov 2002 23:51:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Martin Mares <mj@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend-to-ram: don't crash when kernel gets big
Message-ID: <20021124225125.GA5115@atrey.karlin.mff.cuni.cz>
References: <20021123195525.GA2776@elf.ucw.cz> <20021124224934.GA3252@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021124224934.GA3252@ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +	pushl	$0						# Kill any dangerous flags
> > +	popfl
> > +	cli
> > +	cld
> 
> Seems like you're trying to be 200% sure ;-)

I was not sure if cli really *clears* it as name implies :-).

							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
