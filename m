Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316484AbSEOUKB>; Wed, 15 May 2002 16:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSEOUJC>; Wed, 15 May 2002 16:09:02 -0400
Received: from [195.39.17.254] ([195.39.17.254]:32407 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316487AbSEOUIV>;
	Wed, 15 May 2002 16:08:21 -0400
Date: Wed, 15 May 2002 14:43:00 +0000
From: Pavel Machek <pavel@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
        Neil Conway <nconway.list@ukaea.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
Message-ID: <20020515144300.D37@toy.ucw.cz>
In-Reply-To: <E177b8s-0007lm-00@the-village.bc.nu> <3CE0F0D0.7050404@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> interrupts bite us here. Someone just please shoot this enginer
> who saved the few pullup resistors in the head or send him alternatively
> for "hunting white bears" in Siberia... about 15 years would be fine in my
> opinnion.

Actually, at least unknown card wanting attetion does not kill whole system
like in level-triggered case. You can use timer to recover lost interrupts,
or you just should not loose them in the first place.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

