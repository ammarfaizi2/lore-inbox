Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWIWLJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWIWLJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 07:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWIWLJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 07:09:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5566 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750760AbWIWLJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 07:09:56 -0400
Date: Sat, 23 Sep 2006 13:09:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Eric Sandall <eric@sandall.us>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: suspend broken in 2.6.18
Message-ID: <20060923110954.GD20778@elf.ucw.cz>
References: <45144C61.5020104@sandall.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45144C61.5020104@sandall.us>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> After updating from 2.6.17.13 to 2.6.18 (using `make oldconfig`),
> suspend no longer suspends my laptop (Dell Inspiron 5100).
> 
> # s2ram -f
> Switching from vt7 to vt1
> s2ram_do: Invalid argument
> switching back to vt7
> 
> The screen blanks, but then comes back up after a few seconds. This
> happens both with and without X running.
> 
> I've attached the output of `lspci -vvv` and my
> /usr/src/linux-2.6.18/.config for more information. Please let me know
> if there are any patches to try or if more information is required.

Relevant part of dmesg after failed attempt is neccessary... and you
can probably read it yourself and figure what is wrong. I'd guess some
device just failed to suspend... rmmod it.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
