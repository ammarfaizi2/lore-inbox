Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbTAZVgg>; Sun, 26 Jan 2003 16:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbTAZVgg>; Sun, 26 Jan 2003 16:36:36 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:12294 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S266995AbTAZVgg>;
	Sun, 26 Jan 2003 16:36:36 -0500
Date: Sun, 26 Jan 2003 22:45:50 +0100
From: Martin Mares <mj@ucw.cz>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: geert@linux-m68k.org, Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030126214550.GB6873@ucw.cz>
References: <20030126181326.A799@localhost.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030126181326.A799@localhost.park.msu.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> But on modern systems (titan and marvel), the firmware supports vga
> on *any* bus. Even worse, marvel doesn't have dedicated "legacy"
> hose at all.

> So we have to decode and fix IO port addresses inside our in/out
> functions, which is awful.

Is the problem really only with VGA? Shouldn't we introduce
isa_(in|out)(b|w) instead and remap the whole legacy I/O space?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Don't take life too seriously -- you'll never get out of it alive.
