Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319292AbSHGTma>; Wed, 7 Aug 2002 15:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319296AbSHGTma>; Wed, 7 Aug 2002 15:42:30 -0400
Received: from [195.39.17.254] ([195.39.17.254]:25216 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319292AbSHGTmD>;
	Wed, 7 Aug 2002 15:42:03 -0400
Date: Thu, 1 Nov 2001 23:48:25 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: mporter@mvista.com, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.30/arch/arm/mach-iop310/iq80310-pci.c BUG_ON(cond1 || cond2) separation
Message-ID: <20011101234824.A69@toy.ucw.cz>
References: <20020805131740.A2433@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020805131740.A2433@baldur.yggdrasil.com>; from adam@yggdrasil.com on Mon, Aug 05, 2002 at 01:17:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	I want to replace all statements in the kernel of the form
> BUG_ON(condition1 || condition2) with:
> 
> 			BUG_ON(condition1);
> 			BUG_ON(condition2);
> 
> 	I was recently bitten by a very sporadic BUG_ON(cond1 || cond2)
> statement and was quite annoyed at the greatly reduced opportunity to
> debug the problem.  Make these changes and someone who experiences
> the problem may be able to provide slightly more useful information.

it makes code slower/bigger... probably bad idea

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

