Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311454AbSDIUhY>; Tue, 9 Apr 2002 16:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311475AbSDIUhX>; Tue, 9 Apr 2002 16:37:23 -0400
Received: from [195.39.17.254] ([195.39.17.254]:16011 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S311454AbSDIUhW>;
	Tue, 9 Apr 2002 16:37:22 -0400
Date: Mon, 8 Apr 2002 01:25:37 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: user-mode port 0.56-2.4.18-15
Message-ID: <20020408012536.A329@toy.ucw.cz>
In-Reply-To: <200204082056.PAA03749@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Added SA_SAMPLE_RANDOM to the irq registration flags of some drivers.  This
> makes apps which read /dev/random work a lot better.  Randomness in UML is
> more problematic than on the host, but I chose a set of drivers whose
> interrupts shouldn't be too predictable.

Why don't you just feed your /dev/random from hosts /dev/random?

> HZ is now 52.

Wow.. Why such strange value?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

