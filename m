Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286453AbRLTXEu>; Thu, 20 Dec 2001 18:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286457AbRLTXEl>; Thu, 20 Dec 2001 18:04:41 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:4364 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S286453AbRLTXE2>;
	Thu, 20 Dec 2001 18:04:28 -0500
Date: Thu, 20 Dec 2001 23:40:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Cory Bell <cory.bell@usa.net>, linux-kernel@vger.kernel.org,
        John Clemens <john@deater.net>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011220234055.A133@elf.ucw.cz>
In-Reply-To: <20011219225330.A517@elf.ucw.cz> <Pine.LNX.4.33.0112202235520.919-100000@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112202235520.919-100000@vaio>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Cruel hack to route every link to irq 11 (may of course lock up your box)
> 
> setpci -s 7.0 49.b=99

Huh, this did the trick! Interrupts now arrive correctly to the
soundcard. Recording is still broken, but that's probably separate
problem. (I did not even need those two other setpci's ;-)

								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
