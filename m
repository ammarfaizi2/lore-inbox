Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWEaNz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWEaNz1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWEaNz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:55:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45451 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965023AbWEaNzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:55:25 -0400
Date: Wed, 31 May 2006 15:56:49 +0200
From: Martin Mares <mj@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jon Smirl <jonsmirl@gmail.com>, Ondrej Zajicek <santiago@mail.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <mj+md-20060531.135514.22694.atrey@ucw.cz>
References: <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <20060530223513.GA32267@localhost.localdomain> <9e4733910605301555o287cbd18i99c8813ca6592494@mail.gmail.com> <mj+md-20060531.064701.10737.atrey@ucw.cz> <20060531133436.GA1875@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531133436.GA1875@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Problem is: it messes up design for everyone else. (And no, Santiago,
> most people are not using vgacon. Most people use vesafb these days,
> because that's what allows whole screen to be used, not just 80x25).
> 
> fbcon is simple enough. Okay, vgacon may be useful for recovery, but
> supporting accelerated 3D over vgacon is quite crazy.

I don't say accelerated 3D over vgacon should be supported.

It might be nice to have a choice of either the most basic vgacon,
or a frame buffer console with acceleration and everything else.
Even better with easy switching between these two.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Immanuel doesn't pun, he Kant.
