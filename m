Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbULPBZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbULPBZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbULPBVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:21:20 -0500
Received: from mail.dif.dk ([193.138.115.101]:22438 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262612AbULPBFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:05:46 -0500
Date: Thu, 16 Dec 2004 02:16:11 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/30] return statement cleanup - kill pointless parentheses
In-Reply-To: <20041216010012.GB6285@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0412160213140.3864@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412160010550.3864@dragon.hygekrogen.localhost>
 <20041216010012.GB6285@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Pavel Machek wrote:

> Hi!
> 
> > Ok, here's the first batch of return statement cleanups (*many* to go).
> > 
> > The following patches clean up return statements of the forms
> > 	return(foo);
> > 	return ( fn() );
> > 	return (123);
> > 	return(a + b);
> > etc. To be instead
> > 	return foo;
> > 	return fn();
> > 	return 123
> > 	return a + b;
> 
> Yes, I like that. Please also go through drivers/acpi -- there's lot
> of annoying parenthesis there ;-).
> 								Pavel

Sure thing, I'll add that to my must_do list :)
There seems to be very mixed feelings about this, so I think what I'll do 
is to pick a few files from different dirs and submit patches for them, if 
I then get positive feedback I'll do more in that dir, if not I'll just 
leave it.
Thank you for responding. 

-- 
Jesper Juhl

