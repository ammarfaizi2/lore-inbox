Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbULPBT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbULPBT3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbULPBTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:19:16 -0500
Received: from gprs215-43.eurotel.cz ([160.218.215.43]:44930 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262577AbULPBAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:00:31 -0500
Date: Thu, 16 Dec 2004 02:00:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/30] return statement cleanup - kill pointless parentheses
Message-ID: <20041216010012.GB6285@elf.ucw.cz>
References: <Pine.LNX.4.61.0412160010550.3864@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412160010550.3864@dragon.hygekrogen.localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Ok, here's the first batch of return statement cleanups (*many* to go).
> 
> The following patches clean up return statements of the forms
> 	return(foo);
> 	return ( fn() );
> 	return (123);
> 	return(a + b);
> etc. To be instead
> 	return foo;
> 	return fn();
> 	return 123
> 	return a + b;

Yes, I like that. Please also go through drivers/acpi -- there's lot
of annoying parenthesis there ;-).
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
