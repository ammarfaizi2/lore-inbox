Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbSKGXvX>; Thu, 7 Nov 2002 18:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266649AbSKGXvX>; Thu, 7 Nov 2002 18:51:23 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:28861 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S266640AbSKGXvW>; Thu, 7 Nov 2002 18:51:22 -0500
Date: Thu, 7 Nov 2002 16:57:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Templates and tweaks (for size performance and more)
Message-ID: <20021107235758.GG6164@opus.bloom.county>
References: <20021107190910.GC6164@opus.bloom.county> <20021107210304.C11437@flint.arm.linux.org.uk> <20021107210808.D11437@flint.arm.linux.org.uk> <20021107221017.GB12151@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107221017.GB12151@opus.bloom.county>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 03:10:17PM -0700, Tom Rini wrote:
> On Thu, Nov 07, 2002 at 09:08:08PM +0000, Russell King wrote:
> > Oh, there's another problem built into this method as well.
> > 
> > Instead of one "tweak" depending on one configuration option, it suddenly
> > depends on a whole load of configuration options.  You change one of these
> > options, and you rebuild everything that uses the asm/tweaks.h (or whatever
> > the filename was.)
> > 
> > IMHO this is a backward step. ;(
> 
> That is annoying.  But I'm not quite sure how this doesn't happen for
> <linux/config.h>.  Is it just the <linux/config.h> -> <linux/autoconf.h>
> which is what is actually changed?  Or is there more magic to it?

I've found fixdep and split-include (Thanks Kai!) and I'm going to try
and figure out a clean way to do this.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
