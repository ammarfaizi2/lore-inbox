Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSKBRso>; Sat, 2 Nov 2002 12:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbSKBRrW>; Sat, 2 Nov 2002 12:47:22 -0500
Received: from [195.39.17.254] ([195.39.17.254]:15876 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261325AbSKBRrT>;
	Sat, 2 Nov 2002 12:47:19 -0500
Date: Sat, 2 Nov 2002 17:55:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: Dave Jones <davej@codemonkey.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [announce] swap mini-howto
Message-ID: <20021102165503.GC1983@elf.ucw.cz>
References: <Pine.LNX.4.33L2.0211011540140.28320-100000@dragon.pdx.osdl.net> <20021102000907.GA9229@suse.de> <3DC3207A.450402B3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC3207A.450402B3@zip.com.au>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> That has changed in 2.5.  Swapping onto a regular file has no
> disadvantage wrt swapping onto a block device.  The kernel does
> not need to allocate any memory at all to get a swapcache page
> onto disk.
> 
> Which is interesting.  Because swapfiles are much easier to administer,
> and much easier to stripe.  Adding, removing and resizing is simplified.
> Distributors of 2.6-based kernels could consider doing away with
> swapdevs altogether.

Well, you can swsusp to partition. You can't swsusp to a file, as that
is very hard to do.
								Pavel
-- 
When do you have heart between your knees?
