Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbSKZUBG>; Tue, 26 Nov 2002 15:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266793AbSKZUBF>; Tue, 26 Nov 2002 15:01:05 -0500
Received: from [195.39.17.254] ([195.39.17.254]:16132 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266777AbSKZUA5>;
	Tue, 26 Nov 2002 15:00:57 -0500
Date: Tue, 26 Nov 2002 14:53:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>,
       anton@samba.org, "David S. Miller" <davem@redhat.com>, ak@muc.de
Subject: Re: [PATCH] Beginnings of conpat 32 code cleanups
Message-ID: <20021126135301.GB1268@zaurus>
References: <20021122162312.32ff4bd3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021122162312.32ff4bd3.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There is a lot of duplicated code among the 32 compatibility layers in our
> 64 bit architectures.  I am proposing to considate this as much as
> possible. To that end, I first need to tidy up the relevant header files
> and make them as common as possible.  Discussions with Dave Miller, Andi
> Kleen, and Anton Blanchard has led to the creation of compat32.h to
> contain all the 32 compatibility data types.
> 
> This patch merely adds include/asm-generic/compat32.h which is the header
> information that is common to all the 32 bit compatibility code across all
> the architectures (except parisc as I don't pretend to understand that
> :-)).
> 
> I will follow this up with patches for each architecture that I can. I

I'll be happy to test anything you have on
x86-64...

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

