Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSKXWmV>; Sun, 24 Nov 2002 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSKXWmV>; Sun, 24 Nov 2002 17:42:21 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:32010 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S261857AbSKXWmV>;
	Sun, 24 Nov 2002 17:42:21 -0500
Date: Sun, 24 Nov 2002 23:49:34 +0100
From: Martin Mares <mj@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend-to-ram: don't crash when kernel gets big
Message-ID: <20021124224934.GA3252@ucw.cz>
References: <20021123195525.GA2776@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021123195525.GA2776@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +	pushl	$0						# Kill any dangerous flags
> +	popfl
> +	cli
> +	cld

Seems like you're trying to be 200% sure ;-)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
First law of socio-genetics: Celibacy is not hereditary.
